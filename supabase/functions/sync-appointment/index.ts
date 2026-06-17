import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { getActiveGoogleToken, getOrCreateCalendar } from "../shared/google-client.ts";

serve(async (req: Request) => {
  try {
    const payload = await req.json();
    const { type, record, old_record } = payload;

    if (!record) {
      return new Response("Missing record in payload", { status: 400 });
    }

    const { id: apptId, org_id: orgId, title, notes, start_time, end_time, google_event_id: googleEventId, is_deleted: isDeleted } = record;

    const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
    const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey);

    // Fetch integration settings to see if Google is connected
    const { data: integration, error: integrationError } = await supabaseAdmin
      .from("integration_settings")
      .select("type")
      .eq("org_id", orgId)
      .maybeSingle();

    if (integrationError || !integration || integration.type !== "google") {
      return new Response("Google integration not active, skipping sync.");
    }

    const credentials = await getActiveGoogleToken(orgId);
    const calendarId = await getOrCreateCalendar(orgId, credentials.accessToken, credentials.calendarId);

    // --- CASE 1: DELETE OR SOFT DELETE ---
    if (type === "DELETE" || isDeleted === true) {
      const targetEventId = googleEventId || (old_record ? old_record.google_event_id : null);
      if (targetEventId) {
        console.log(`Deleting Google Calendar event ${targetEventId}...`);
        const delRes = await fetch(
          `https://www.googleapis.com/calendar/v3/calendars/${calendarId}/events/${targetEventId}`,
          {
            method: "DELETE",
            headers: {
              Authorization: `Bearer ${credentials.accessToken}`,
            },
          }
        );

        if (!delRes.ok && delRes.status !== 404 && delRes.status !== 410) {
          const errText = await delRes.text();
          console.error(`Google Calendar event delete failed: ${errText}`);
        }

        if (type !== "DELETE") {
          await supabaseAdmin
            .from("appointments")
            .update({ google_event_id: null })
            .eq("id", apptId);
        }
      }
      return new Response("ok (deleted/soft-deleted)");
    }

    // Skip if start_time or end_time are missing
    if (!start_time || !end_time) {
      return new Response("Missing start_time or end_time, skipping sync.");
    }

    const event = {
      summary: title || "Tattoo Appointment",
      description: notes || "",
      start: {
        dateTime: new Date(start_time).toISOString(),
      },
      end: {
        dateTime: new Date(end_time).toISOString(),
      },
    };

    // --- CASE 2: UPDATE ---
    if (googleEventId) {
      console.log(`Updating Google Calendar event ${googleEventId}...`);
      const updateRes = await fetch(
        `https://www.googleapis.com/calendar/v3/calendars/${calendarId}/events/${googleEventId}`,
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
        return new Response("ok (updated)");
      } else if (updateRes.status === 404 || updateRes.status === 410) {
        // Recreate if missing
        console.log("Calendar event not found on Google. Recreating...");
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
            .eq("id", apptId);
          return new Response("ok (recreated)");
        } else {
          throw new Error(`Google Calendar recreate failed: ${await createRes.text()}`);
        }
      } else {
        throw new Error(`Google Calendar update failed: ${await updateRes.text()}`);
      }
    }

    // --- CASE 3: INSERT ---
    console.log("Creating new Google Calendar event...");
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
        .eq("id", apptId);
      return new Response("ok (inserted)");
    } else {
      throw new Error(`Google Calendar create failed: ${await createRes.text()}`);
    }
  } catch (error: any) {
    console.error("sync-appointment error:", error);
    return new Response(`Error: ${error.message}`, { status: 500 });
  }
});
