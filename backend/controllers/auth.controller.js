import User from "../models/User.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import crypto from "crypto";
import { transporter } from "../email/mailer.js";

// LOGIN
export const login = async (req, res) => {
  const { email, password } = req.body;
  console.log(email);
  
  const user = await User.findOne({ "email": email });
  if (!user) return res.status(404).json({ message: "User not found" + email });

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return res.status(401).json({ message: "Invalid password" });

  const token = jwt.sign(
    { id: user._id, role: user.role },
    process.env.JWT_SECRET,
    { expiresIn: "1d" }
  );

  res.json({ token, user });
};

// FORGOT PASSWORD
const generateResetCode = () => {
  return crypto.randomInt(100000, 999999).toString(); // 6 chiffres
};

export const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Génération du code aléatoire
    const resetCode = generateResetCode();

    // Stockage en base
    user.resetCode = resetCode;
    user.resetCodeExpiration = Date.now() + 15 * 60 * 1000; // 15 minutes
    await user.save();

    await transporter.sendMail({
      from: `"Support" <${process.env.EMAIL_USER}>`,
      to: email,
      subject: "Password Reset Code",
      html: `
        <h2>Password Reset</h2>
        <p>Your password reset verification code is:</p>
        <h1 style="letter-spacing:4px;">${resetCode}</h1>
        <p>This code will expire in 15 minutes.</p>
        <p>If you did not request this, ignore this email.</p>
      `,
    });

    res.json({ message: "Reset code sent to email" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// RESET PASSWORD
// VERIFY RESET CODE
export const verifyResetCode = async (req, res) => {
  try {
    const { code } = req.body;

    console.log('Verifying code:', { code, type: typeof code });

    const user = await User.findOne({
      resetCode: code.toString(),
      resetCodeExpiration: { $gt: Date.now() },
    });

    console.log('User found:', user ? 'Yes' : 'No');

    if (!user) {
      console.log('Code not found or expired. Provided code:', code);
      return res.status(400).json({ message: "Invalid or expired code" });
    }

    res.json({ message: "Code verified successfully" });
  } catch (error) {
    console.error('Verify code error:', error);
    res.status(500).json({ message: error.message });
  }
};
export const resetPassword = async (req, res) => {
  try {
    const { email, code, newPassword } = req.body;

    const user = await User.findOne({
      email,
      resetCode: code,
      resetCodeExpiration: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(400).json({ message: "Invalid or expired code" });
    }

    user.password = await bcrypt.hash(newPassword, 10);
    user.resetCode = null;
    user.resetCodeExpiration = null;
    console.log(user);
    
    await user.save();

    res.json({ message: "Password reset successful" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
