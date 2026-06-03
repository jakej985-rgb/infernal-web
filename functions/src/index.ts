import {setGlobalOptions} from "firebase-functions";
import {onRequest} from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import express from "express";
import {clientRouter} from "./routes/client.routes";

// Initialize Firebase Admin SDK
admin.initializeApp();

// Global configuration
setGlobalOptions({maxInstances: 10});

const app = express();
app.use(express.json());

// Public health check route
app.get("/health", (req: express.Request, res: express.Response) => {
  res.status(200).json({status: "OK", timestamp: new Date().toISOString()});
});

// Protected routes
app.use("/clients", clientRouter);

// Export cloud function endpoint
export const api = onRequest(app);
