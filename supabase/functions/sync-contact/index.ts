import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { getActiveGoogleToken } from "../shared/google-client.ts";

serve(async (req: Request) => {
  try {
    const payload = await req.json();
    const { type, record, old_record } = payload;

    if (!record) {
      return new Response("Missing record in payload", { status: 400 });
    }

    const { id: clientId, org_id: orgId, first_name, last_name, email, phone, notes, google_contact_resource_name: googleContactName, is_deleted: isDeleted } = record;

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

    // --- CASE 1: DELETE OR SOFT DELETE ---
    if (type === "DELETE" || isDeleted === true) {
      const targetResourceName = googleContactName || (old_record ? old_record.google_contact_resource_name : null);
      if (targetResourceName) {
        console.log(`Deleting Google Contact ${targetResourceName}...`);
        const delRes = await fetch(
          `https://people.googleapis.com/v1/${targetResourceName}:deleteContact`,
          {
            method: "DELETE",
            headers: {
              Authorization: `Bearer ${credentials.accessToken}`,
            },
          }
        );

        if (!delRes.ok && delRes.status !== 404 && delRes.status !== 410) {
          const errText = await delRes.text();
          console.error(`Google Contact delete failed: ${errText}`);
        }

        if (type !== "DELETE") {
          await supabaseAdmin
            .from("clients")
            .update({ google_contact_resource_name: null })
            .eq("id", clientId);
        }
      }
      return new Response("ok (deleted/soft-deleted)");
    }

    const contactData = {
      names: [
        {
          givenName: first_name || "",
          familyName: last_name || "",
        },
      ],
      emailAddresses: email ? [{ value: email }] : [],
      phoneNumbers: phone ? [{ value: phone }] : [],
      biographies: notes ? [{ value: notes }] : [],
    };

    // --- CASE 2: UPDATE ---
    if (googleContactName) {
      console.log(`Updating Google Contact ${googleContactName}...`);
      
      // Fetch the contact first to get its etag
      const getRes = await fetch(
        `https://people.googleapis.com/v1/${googleContactName}?personFields=names,emailAddresses,phoneNumbers,biographies`,
        {
          headers: {
            Authorization: `Bearer ${credentials.accessToken}`,
          },
        }
      );

      if (getRes.ok) {
        const getData = await getRes.json();
        const etag = getData.etag;

        // Perform the patch update
        const updateRes = await fetch(
          `https://people.googleapis.com/v1/${googleContactName}:updateContact?updatePersonFields=names,emailAddresses,phoneNumbers,biographies`,
          {
            method: "PATCH",
            headers: {
              Authorization: `Bearer ${credentials.accessToken}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              etag,
              ...contactData,
            }),
          }
        );

        if (updateRes.ok) {
          return new Response("ok (updated)");
        } else {
          throw new Error(`Google Contact patch failed: ${await updateRes.text()}`);
        }
      } else if (getRes.status === 404 || getRes.status === 410) {
        // Recreate if missing on Google Contacts
        console.log("Contact not found on Google. Recreating...");
        const createRes = await fetch(
          "https://people.googleapis.com/v1/people:createContact",
          {
            method: "POST",
            headers: {
              Authorization: `Bearer ${credentials.accessToken}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify(contactData),
          }
        );

        if (createRes.ok) {
          const createData = await createRes.json();
          await supabaseAdmin
            .from("clients")
            .update({ google_contact_resource_name: createData.resourceName })
            .eq("id", clientId);
          return new Response("ok (recreated)");
        } else {
          throw new Error(`Google Contact recreate failed: ${await createRes.text()}`);
        }
      } else {
        throw new Error(`Google Contact fetch failed with status ${getRes.status}: ${await getRes.text()}`);
      }
    }

    // --- CASE 3: INSERT ---
    console.log("Creating new Google Contact...");
    const createRes = await fetch(
      "https://people.googleapis.com/v1/people:createContact",
      {
        method: "POST",
        headers: {
          Authorization: `Bearer ${credentials.accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify(contactData),
      }
    );

    if (createRes.ok) {
      const createData = await createRes.json();
      await supabaseAdmin
        .from("clients")
        .update({ google_contact_resource_name: createData.resourceName })
        .eq("id", clientId);
      return new Response("ok (inserted)");
    } else {
      throw new Error(`Google Contact create failed: ${await createRes.text()}`);
    }
  } catch (error: any) {
    console.error("sync-contact error:", error);
    return new Response(`Error: ${error.message}`, { status: 500 });
  }
});
