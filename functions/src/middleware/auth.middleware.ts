import {Request, Response, NextFunction} from "express";
import * as admin from "firebase-admin";

export interface AuthenticatedRequest extends Request {
  user?: admin.auth.DecodedIdToken;
  orgId?: string;
}

/**
 * Authentication middleware that verifies the Bearer ID token with Firebase Admin
 * and checks organization membership.
 * @param req The authenticated request
 * @param res Express response object
 * @param next Next function callback
 */
export async function authMiddleware(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      res.status(401).json({
        error: "Unauthorized: Missing or invalid token format.",
      });
      return;
    }

    const token = authHeader.split("Bearer ")[1];
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.user = decodedToken;

    // Get orgId from x-org-id header
    const orgId = req.headers["x-org-id"] as string;
    if (!orgId) {
      res.status(400).json({
        error: "Bad Request: Missing x-org-id header.",
      });
      return;
    }
    req.orgId = orgId;

    // Validate organization membership matching Firestore rules
    const userDoc = await admin.firestore()
      .collection("organizations")
      .doc(orgId)
      .collection("users")
      .doc(decodedToken.uid)
      .get();

    if (!userDoc.exists) {
      res.status(403).json({
        error: "Forbidden: You are not a member of this organization.",
      });
      return;
    }

    next();
  } catch (error) {
    const msg = error instanceof Error ? error.message : error;
    res.status(401).json({
      error: `Unauthorized: ${msg}`,
    });
  }
}
