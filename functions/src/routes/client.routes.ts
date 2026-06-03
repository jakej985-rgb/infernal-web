/* eslint-disable new-cap */
import express, {Router} from "express";
import {createClient} from "../controllers/client.controller";
import {authMiddleware} from "../middleware/auth.middleware";

const router = Router();

// Apply auth middleware to all client routes
router.use(authMiddleware as unknown as express.RequestHandler);

router.post("/", createClient as unknown as express.RequestHandler);

export const clientRouter = router;
