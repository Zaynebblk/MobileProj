import express from "express";
import { login, forgotPassword, resetPassword, verifyResetCode } from "../controllers/auth.controller.js";

const router = express.Router();

// Auth routes
router.post("/api/auth/login", login);
router.post("/api/auth/forgot-password", forgotPassword);
router.post("/api/auth/reset-password", resetPassword);
router.post("/api/auth/verify-reset-code", verifyResetCode);

// Redirect route for email reset links
router.get("/reset-password/:token", (req, res) => {
  const { token } = req.params;
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Redirecting to Reset Password...</title>
    </head>
    <body>
      <p>Redirecting to reset password page...</p>
      <script>
        // Redirect to Flutter app with token
        window.location.href = 'http://localhost:52211/#/reset-password?token=${token}';
      </script>
    </body>
    </html>
  `);
});

export default router;
