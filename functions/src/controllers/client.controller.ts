import {Response} from "express";
import {AuthenticatedRequest} from "../middleware/auth.middleware";
import {ClientService} from "../services/client.service";

const clientService = new ClientService();

/**
 * Express handler to create a new client.
 * @param req Authenticated express request
 * @param res Express response
 */
export async function createClient(
  req: AuthenticatedRequest,
  res: Response
): Promise<void> {
  try {
    const orgId = req.orgId!;
    const {name, email, phone} = req.body;

    if (!name || typeof name !== "string" || name.trim() === "") {
      res.status(400).json({error: "Bad Request: name is required."});
      return;
    }

    const clientId = await clientService.createClient(orgId, {
      name: name.trim(),
      email: email ? String(email).trim() : undefined,
      phone: phone ? String(phone).trim() : undefined,
    });

    res.status(201).json({id: clientId});
  } catch (error) {
    const msg = error instanceof Error ? error.message : error;
    res.status(500).json({error: `Internal Server Error: ${msg}`});
  }
}
