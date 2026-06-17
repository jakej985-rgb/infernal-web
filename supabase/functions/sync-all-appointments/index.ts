import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { getActiveGoogleToken, getOrCreateCalendar } from "../shared/google-client.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

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

    const { orgId } = await req.json();
    if (!orgId) {
      return new Response(JSON.stringify({ error: "Missing orgId" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    const supabaseAdmin = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // Fetch active integration type
    const { data: integration, error: integrationError } = await supabaseAdmin
      .from("integration_settings")
      .select("type")
      .eq("org_id", orgId)
      .maybeSingle();

    if (integrationError || !integration || integration.type !== "google") {
      return new Response(JSON.stringify({ error: "Google integration is not active" }), {
        status: 400,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      });
    }

    // Load credentials and calendar ID
    const credentials = await getActiveGoogleToken(orgId);
    const calendarId = await getOrCreateCalendar(orgId, credentials.accessToken, credentials.calendarId);

    // Fetch active appointments
    const { data: appointments, error: apptError } = await supabaseAdmin
      .from("appointments")
      .select("id, title, notes, start_time, end_time, google_event_id")
      .eq("org_id", orgId)
      .eq("is_deleted", false);

    if (apptError) {
      throw new Error(`Failed to load appointments: ${apptError.message}`);
    }

    let successCount = 0;
    let failureCount = 0;

    for (const appt of appointments || []) {
      if (!appt.start_time || !appt.end_time) {
        continue;
      }

      const event = {
        summary: appt.title || "Tattoo Appointment",
        description: appt.notes || "",
        start: {
          dateTime: new Date(appt.start_time).toISOString(),
        },
        end: {
          dateTime: new Date(appt.end_time).toISOString(),
        },
      };

      try {
        if (appt.google_event_id) {
          // Update event on Google Calendar
          const updateRes = await fetch(
            `https://www.googleapis.com/calendar/v3/calendars/${calendarId}/events/${appt.google_event_id}`,
            {
              method: "PUT",
              headers: {
                Authorization: `Bearer ${credentials.accessToken}`,
                "Content-Type": "application/json",
              },
              body: JSON.stringify(event),
            }
          );

          if (updateRes.ok) {
            successCount++;
          } else if (updateRes.status === 404 || updateRes.status === 410) {
            // Recreate if deleted on Google Calendar
            const createRes = await fetch(
              `https://www.googleapis.com/calendar/v3/calendars/${calendarId}/events`,
              {
                method: "POST",
                headers: {
                  Authorization: `Bearer ${credentials.accessToken}`,
                  "Content-Type": "application/json",
                },
                body: JSON.stringify(event),
              }
            );

            if (createRes.ok) {
              const createData = await createRes.json();
              await supabaseAdmin
                .from("appointments")
                .update({ google_event_id: createData.id })
                .eq("id", appt.id);
              successCount++;
            } else {
              failureCount++;
            }
          } else {
            console.error(`Google update event failed with status ${updateRes.status}:`, await updateRes.text());
            failureCount++;
          }
        } else {
          // Insert new event on Google Calendar
          const createRes = await fetch(
            `https://www.googleapis.com/calendar/v3/calendars/${calendarId}/events`,
            {
              method: "POST",
              headers: {
                Authorization: `Bearer ${credentials.accessToken}`,
                "Content-Type": "application/json",
              },
              body: JSON.stringify(event),
            }
          );

          if (createRes.ok) {
            const createData = await createRes.json();
            await supabaseAdmin
              .from("appointments")
              .update({ google_event_id: createData.id })
              .eq("id", appt.id);
            successCount++;
          } else {
            console.error(`Google create event failed:`, await createRes.text());
            failureCount++;
          }
        }
      } catch (err) {
        console.error(`Failed to sync appointment ${appt.id}:`, err);
        failureCount++;
      }
    }

    return new Response(JSON.stringify({ success: true, synced: successCount, failed: failureCount }), {
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  } catch (error: any) {
    console.error("sync-all-appointments error:", error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { ...corsHeaders, "Content-Type": "application/json" },
    });
  }
});
