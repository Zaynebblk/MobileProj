// models/User.js
import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  password: String,
  role: {
    type: String,
    enum: ["student", "teacher", "admin"],
    default: "student",
  },
  resetToken: String,
  resetTokenExpiration: Date,
  resetCode: {
  type: String,
},
resetCodeExpiration: {
  type: Date,
},

});

export default mongoose.model("User", userSchema);
