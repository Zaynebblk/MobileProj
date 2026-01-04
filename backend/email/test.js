import nodemailer from "nodemailer";
import { transporter } from "./mailer.js";
async function testEmail() {
  try {
    await transporter.sendMail({
      from: "edxapplication75@gmail.com",
      to: "zaynebbelkhiria5@gmail.com",
      subject: "Test Nodemailer",
      text: "It works!",
    });
    console.log("Email sent successfully!");
  } catch (err) {
    console.error(err);
  }
}

testEmail();
