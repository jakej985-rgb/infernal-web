import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
};

serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  const url = new URL(req.url);
  const code = url.searchParams.get("code");
  const stateStr = url.searchParams.get("state");

  const clientId = Deno.env.get("GOOGLE_CLIENT_ID");
  const clientSecret = Deno.env.get("GOOGLE_CLIENT_SECRET");
  const redirectUri = Deno.env.get("GOOGLE_REDIRECT_URI") || `${url.origin}/functions/v1/auth-google`;

  if (!clientId || !clientSecret) {
    return new Response("Google client credentials are not configured on the server.", { status: 500 });
  }

  // --- Step 1: Initiate OAuth Redirect ---
  if (!code) {
    const orgId = url.searchParams.get("orgId");
    const redirectUrl = url.searchParams.get("redirectUrl") || "";

    if (!orgId) {
      return new Response("Missing orgId query parameter.", { status: 400 });
    }

    const state = JSON.stringify({ orgId, redirectUrl });
    const scopes = [
      "openid",
      "email",
      "profile",
      "https://www.googleapis.com/auth/gmail.send",
      "https://www.googleapis.com/auth/calendar",
      "https://www.googleapis.com/auth/contacts",
    ];

    const authUrl =
      "https://accounts.google.com/o/oauth2/v2/auth?" +
      new URLSearchParams({
        client_id: clientId,
        redirect_uri: redirectUri,
        response_type: "code",
        scope: scopes.join(" "),
        access_type: "offline",
        prompt: "consent",
        state: state,
      });

    return Response.redirect(authUrl, 302);
  }

  // --- Step 2: Handle OAuth Callback ---
  if (!stateStr) {
    return new Response("Missing state parameter.", { status: 400 });
  }

  let orgId = "";
  let redirectUrl = "";
  try {
    const parsedState = JSON.parse(stateStr);
    orgId = parsedState.orgId;
    redirectUrl = parsedState.redirectUrl;
  } catch (_err) {
    return new Response("Invalid state parameter.", { status: 400 });
  }

  try {
    // Exchange auth code for tokens
    const tokenRes = await fetch("https://oauth2.googleapis.com/token", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: new URLSearchParams({
        code,
        client_id: clientId,
        client_secret: clientSecret,
        redirect_uri: redirectUri,
        grant_type: "authorization_code",
      }),
    });

    if (!tokenRes.ok) {
      const errorText = await tokenRes.text();
      throw new Error(`Failed to exchange code for token: ${errorText}`);
    }

    const tokens = await tokenRes.json();
    const accessToken = tokens.access_token;
    const refreshToken = tokens.refresh_token; // Only sent on consent prompt
    const expiresIn = tokens.expires_in;
    const expiryDate = Date.now() + (expiresIn * 1000);

    // Get user info (email)
    const userInfoRes = await fetch("https://www.googleapis.com/oauth2/v2/userinfo", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });

    if (!userInfoRes.ok) {
      throw new Error("Failed to retrieve user profile from Google.");
    }

    const userInfo = await userInfoRes.json();
    const email = userInfo.email || "";

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // Update integration secrets table
    const secretUpdate: any = {
      org_id: orgId,
      google_access_token: accessToken,
      google_expiry_date: expiryDate,
      updated_at: new Date().toISOString(),
    };
    if (refreshToken) {
      secretUpdate.google_refresh_token = refreshToken;
    }

    const { error: secretsError } = await supabaseAdmin
      .from("integration_secrets")
      .upsert(secretUpdate);

    if (secretsError) {
      throw new Error(`Failed to update integration secrets: ${secretsError.message}`);
    }

    // Update integration settings table
    const { error: settingsError } = await supabaseAdmin
      .from("integration_settings")
      .upsert({
        org_id: orgId,
        type: "google",
        google_connected: true,
        google_email: email,
        google_scopes: tokens.scope ? tokens.scope.split(" ") : [],
        smtp_connected: false,
        updated_at: new Date().toISOString(),
      });

    if (settingsError) {
      throw new Error(`Failed to update integration settings: ${settingsError.message}`);
    }

    if (redirectUrl) {
      // Append a success query parameter if redirecting back to the app
      const targetUrl = new URL(redirectUrl);
      targetUrl.searchParams.set("google_connected", "true");
      return Response.redirect(targetUrl.toString(), 302);
    } else {
      return new Response("Google Account connected successfully! You may close this tab and return to the app.", {
        headers: { "Content-Type": "text/html" },
      });
    }
  } catch (err: any) {
    console.error("OAuth Callback Error:", err);
    return new Response(`Authentication failed: ${err.message}`, { status: 500 });
  }
});
