import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import crypto from "node:crypto";
import { Buffer } from "node:buffer";
import nodemailer from "npm:nodemailer@^6.9.0";
import { getActiveGoogleToken } from "../shared/google-client.ts";

const ALGORITHM = "aes-256-cbc";

function getSecretKey(): Buffer {
  const keyBase = Deno.env.get("SMTP_ENCRYPTION_KEY") || "infernal-ink-steel-suite-salt-key";
  return crypto.createHash("sha256").update(keyBase).digest();
}

function decrypt(encryptedText: string): string {
  const parts = encryptedText.split(":");
  if (parts.length !== 2) throw new Error("Invalid encrypted text format");
  const iv = Buffer.from(parts[0], "hex");
  const encrypted = parts[1];
  const decipher = crypto.createDecipheriv(ALGORITHM, getSecretKey(), iv);
  let decrypted = decipher.update(encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");
  return decrypted;
}

function makeGmailBody(to: string, from: string, subject: string, htmlMessage: string): string {
  const str = [
    `To: ${to}\r\n`,
    `From: ${from}\r\n`,
    `Subject: =?utf-8?B?${Buffer.from(subject).toString("base64")}?=\r\n`,
    "MIME-Version: 1.0\r\n",
    'Content-Type: text/html; charset="UTF-8"\r\n\r\n',
    htmlMessage,
  ].join("");

  return Buffer.from(str)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

serve(async (req: Request) => {
  try {
    const payload = await req.json();
    const record = payload.record;

    if (!record) {
      return new Response("Missing record in payload", { status: 400 });
    }

    const { id: commId, org_id: orgId, client_id: clientId, content: body } = record;
    const subject = "Ritual Confirmation"; // Default subject

    const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
    const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

    // Fetch client email
    let toEmail = "";
    if (clientId) {
      const { data: client } = await supabaseAdmin
        .from("clients")
        .select("email")
        .eq("id", clientId)
        .maybeSingle();
      if (client && client.email) {
        toEmail = client.email;
      }
    }

    if (!toEmail || !body) {
      console.warn(`Skipping send for comm ${commId} in org ${orgId}: recipient or body missing.`);
      await supabaseAdmin
        .from("communications")
        .update({
          status: "FAILED",
          sent_at: new Date().toISOString(),
        })
        .eq("id", commId);
      return new Response("Skipped: recipient email or body missing");
    }

    // Fetch integration settings
    const { data: integration, error: integrationError } = await supabaseAdmin
      .from("integration_settings")
      .select("type, google_email, smtp_host, smtp_port, smtp_user")
      .eq("org_id", orgId)
      .maybeSingle();

    if (integrationError || !integration || !integration.type) {
      throw new Error("No active email integration configured for this organization.");
    }

    if (integration.type === "google") {
      const credentials = await getActiveGoogleToken(orgId);
      const fromEmail = integration.google_email || "me";

      const gmailBody = makeGmailBody(toEmail, fromEmail, subject, body);

      const sendRes = await fetch("https://gmail.googleapis.com/gmail/v1/users/me/messages/send", {
        method: "POST",
        headers: {
          Authorization: `Bearer ${credentials.accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          raw: gmailBody,
        }),
      });

      if (!sendRes.ok) {
        const errorText = await sendRes.text();
        throw new Error(`Gmail API send failed: ${errorText}`);
      }
    } else if (integration.type === "smtp") {
      // Fetch encrypted password
      const { data: secrets } = await supabaseAdmin
        .from("integration_secrets")
        .select("smtp_password")
        .eq("org_id", orgId)
        .maybeSingle();

      if (!secrets || !secrets.smtp_password) {
        throw new Error("SMTP secret password not found in database.");
      }

      const decryptedPassword = decrypt(secrets.smtp_password);

      const transporter = nodemailer.createTransport({
        host: integration.smtp_host,
        port: Number(integration.smtp_port),
        secure: Number(integration.smtp_port) === 465,
        auth: {
          user: integration.smtp_user,
          pass: decryptedPassword,
        },
      });

      await transporter.sendMail({
        from: integration.smtp_user,
        to: toEmail,
        subject: subject,
        html: body,
      });
    }

    // Update status to SENT
    await supabaseAdmin
      .from("communications")
      .update({
        status: "SENT",
        sent_at: new Date().toISOString(),
      })
      .eq("id", commId);

    return new Response("ok");
  } catch (error: any) {
    console.error("send-email error:", error);
    try {
      const payload = await req.json().catch(() => ({}));
      const record = payload.record;
      if (record && record.id) {
        const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
        const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
        const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);
        await supabaseAdmin
          .from("communications")
          .update({
            status: "FAILED",
            sent_at: new Date().toISOString(),
          })
          .eq("id", record.id);
      }
    } catch (dbErr) {
      console.error("Failed to update status to FAILED in DB:", dbErr);
    }
    return new Response(`Error: ${error.message}`, { status: 500 });
  }
});
