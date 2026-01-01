import express from "express";
import { login, forgotPassword, resetPassword } from "../controllers/auth.controller.js";

const router = express.Router();

// Auth routes
router.post("/api/auth/login", login);
router.post("/api/auth/forgot-password", forgotPassword);
router.post("/api/auth/reset-password/:token", resetPassword);
router.post("/api/auth/forgot-password", forgotPassword);
router.post("/api/auth/reset-password/:token", resetPassword);

export default router;
