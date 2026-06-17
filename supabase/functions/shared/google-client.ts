import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

export interface GoogleCredentials {
  accessToken: string;
  refreshToken?: string;
  expiryDate: number;
  calendarId?: string;
}

export async function getActiveGoogleToken(orgId: string): Promise<GoogleCredentials> {
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
  const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

  // Retrieve current secrets
  const { data: secrets, error: secretsError } = await supabaseAdmin
    .from("integration_secrets")
    .select("google_access_token, google_refresh_token, google_expiry_date, google_calendar_id")
    .eq("org_id", orgId)
    .maybeSingle();

  if (secretsError || !secrets) {
    throw new Error("Google secrets not found for this organization.");
  }

  const {
    google_access_token: accessToken,
    google_refresh_token: refreshToken,
    google_expiry_date: expiryDateVal,
    google_calendar_id: calendarId,
  } = secrets;

  const expiryDate = Number(expiryDateVal || 0);

  if (!accessToken || !refreshToken) {
    throw new Error("Google integration is not connected.");
  }

  const now = Date.now();
  // Auto-refresh token if expired (or expiring in < 5 mins)
  if (expiryDate - now < 5 * 60 * 1000) {
    console.log(`Refreshing Google OAuth token for org ${orgId}...`);
    try {
      const clientId = Deno.env.get("GOOGLE_CLIENT_ID")!;
      const clientSecret = Deno.env.get("GOOGLE_CLIENT_SECRET")!;

      const refreshRes = await fetch("https://oauth2.googleapis.com/token", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: new URLSearchParams({
          client_id: clientId,
          client_secret: clientSecret,
          refresh_token: refreshToken,
          grant_type: "refresh_token",
        }),
      });

      if (!refreshRes.ok) {
        const errorText = await refreshRes.text();
        throw new Error(`Google API refresh response error: ${errorText}`);
      }

      const newTokens = await refreshRes.json();
      const newAccessToken = newTokens.access_token;
      const newExpiresIn = newTokens.expires_in;
      const newExpiryDate = Date.now() + (newExpiresIn * 1000);

      // Save updated access token and expiry to DB
      const { error: updateError } = await supabaseAdmin
        .from("integration_secrets")
        .update({
          google_access_token: newAccessToken,
          google_expiry_date: newExpiryDate,
          updated_at: new Date().toISOString(),
        })
        .eq("org_id", orgId);

      if (updateError) {
        console.error("Failed to update database with refreshed token:", updateError);
      }

      return {
        accessToken: newAccessToken,
        refreshToken,
        expiryDate: newExpiryDate,
        calendarId,
      };
    } catch (err: any) {
      console.error(`Error refreshing Google token for org ${orgId}:`, err);
      throw new Error(`Google credentials expired and failed to refresh: ${err.message}`);
    }
  }

  return {
    accessToken,
    refreshToken,
    expiryDate,
    calendarId,
  };
}

export async function getOrCreateCalendar(orgId: string, accessToken: string, existingCalendarId?: string): Promise<string> {
  if (existingCalendarId && existingCalendarId !== "primary") {
    return existingCalendarId;
  }

  // Fetch shop name
  const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
  const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
  const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

  let orgName = "Studio";
  try {
    const { data: org } = await supabaseAdmin
      .from("organizations")
      .select("name")
      .eq("id", orgId)
      .maybeSingle();
    if (org && org.name) {
      orgName = org.name;
    }
  } catch (err) {
    console.warn("Failed to fetch organization name:", err);
  }

  const calendarTitle = "Ink & Steel";

  // Check if calendar already exists on Google Account
  try {
    const listRes = await fetch("https://www.googleapis.com/calendar/v3/users/me/calendarList?minAccessRole=owner", {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    });

    if (listRes.ok) {
      const listData = await listRes.json();
      const existing = (listData.items || []).find((entry: any) => entry.summary === calendarTitle);
      if (existing) {
        // Save calendar ID to database
        await supabaseAdmin
          .from("integration_secrets")
          .update({ google_calendar_id: existing.id })
          .eq("org_id", orgId);
        return existing.id;
      }
    }
  } catch (err) {
    console.warn("Failed to list calendars:", err);
  }

  // Create new calendar
  try {
    const createRes = await fetch("https://www.googleapis.com/calendar/v3/calendars", {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        summary: calendarTitle,
        timeZone: "UTC",
      }),
    });

    if (createRes.ok) {
      const createData = await createRes.json();
      const calendarId = createData.id;
      if (calendarId) {
        await supabaseAdmin
          .from("integration_secrets")
          .update({ google_calendar_id: calendarId })
          .eq("org_id", orgId);
        return calendarId;
      }
    }
  } catch (err) {
    console.error("Failed to create Google Calendar:", err);
  }

  return "primary";
}
