import express from "express";
import cors from "cors";                   // <-- importer cors avant de l'utiliser
import router from "./routes/auth.routes.js";
import { connectDB } from "./config/db.js";
import dotenv from "dotenv";
dotenv.config();
const app = express();

// Middleware pour parser le JSON
app.use(express.json());

// Middleware CORS (important avant les routes)
app.use(cors());

// Middleware optionnel pour logger les requêtes
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// Routes principales
app.use(router);  // <-- utiliser le router après cors et json

app.get("/", (req, res) => {
  res.json({ message: "Server is running 🚀" });
});

const PORT = process.env.PORT; 
const email = process.env.EMAIL_USER;
const pass = process.env.EMAIL_PASS;
console.log(email);
console.log(pass);


connectDB().then(() => {
  console.log("✅ Database connected");
}
);
app.listen(PORT, "0.0.0.0", () => {
  console.log(`✅ Server running on http://0.0.0.0:${PORT}`);
});
