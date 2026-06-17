import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import crypto from "node:crypto";
import { Buffer } from "node:buffer";

const ALGORITHM = "aes-256-cbc";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function getSecretKey(): Buffer {
  const keyBase = Deno.env.get("SMTP_ENCRYPTION_KEY") || "infernal-ink-steel-suite-salt-key";
  return crypto.createHash("sha256").update(keyBase).digest();
}

function encrypt(text: string): string {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(ALGORITHM, getSecretKey(), iv);
  let encrypted = cipher.update(text, "utf8", "hex");
  encrypted += cipher.final("hex");
  return `${iv.toString("hex")}:${encrypted}`;
}

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(JSON.stringify({ error: "Missing Authorization header" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Authenticate user
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: authHeader } } }
    );
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser();
    if (userError || !user) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), {
        status: 401,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const { orgId, host, port, user: smtpUser, password } = await req.json();
    if (!orgId || !host || !port || !smtpUser || !password) {
      return new Response(JSON.stringify({ error: "Missing required arguments" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const encryptedPass = encrypt(password);
    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // Save secret encrypted password
    const { error: secretError } = await supabaseAdmin
      .from("integration_secrets")
      .upsert({
        org_id: orgId,
        smtp_password: encryptedPass,
        updated_at: new Date().toISOString(),
      });

    if (secretError) {
      throw new Error(`Failed to save secrets: ${secretError.message}`);
    }

    // Save public configuration
    const { error: settingsError } = await supabaseAdmin
      .from("integration_settings")
      .upsert({
        org_id: orgId,
        type: "smtp",
        smtp_connected: true,
        smtp_host: host,
        smtp_port: parseInt(port, 10),
        smtp_user: smtpUser,
        google_connected: false,
        updated_at: new Date().toISOString(),
      });

    if (settingsError) {
      throw new Error(`Failed to save settings: ${settingsError.message}`);
    }

    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
