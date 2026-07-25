-- Create pg_net extension if not exists
CREATE EXTENSION IF NOT EXISTS pg_net;

-- Create integration secrets table
CREATE TABLE IF NOT EXISTS public.integration_secrets (
    org_id TEXT REFERENCES public.organizations(id) ON DELETE CASCADE PRIMARY KEY,
    google_access_token TEXT,
    google_refresh_token TEXT,
    google_expiry_date BIGINT,
    google_calendar_id TEXT,
    smtp_password TEXT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS on secrets table
ALTER TABLE public.integration_secrets ENABLE ROW LEVEL SECURITY;

-- Block all public client reads/writes on secrets (only bypassable via service_role API key)
DROP POLICY IF EXISTS "Block all client access to integration_secrets" ON public.integration_secrets;
CREATE POLICY "Block all client access to integration_secrets" 
ON public.integration_secrets 
TO public 
USING (false) 
WITH CHECK (false);

-- 1. Webhook for Communications -> Email Sending
CREATE OR REPLACE FUNCTION public.on_communication_created()
RETURNS TRIGGER LANGUAGE plpgsql
SECURITY DEFINER AS $$
BEGIN
  PERFORM net.http_post(
    url := 'https://nmrnbwnyivxktbjukspu.supabase.co/functions/v1/send-email'::text,
    headers := '{"Content-Type": "application/json"}'::jsonb,
    body := jsonb_build_object(
      'type', TG_OP,
      'table', TG_TABLE_NAME,
      'schema', TG_TABLE_SCHEMA,
      'record', to_jsonb(NEW)
    )
  );
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_communication_created_trigger ON public.communications;
CREATE TRIGGER on_communication_created_trigger
AFTER INSERT ON public.communications
FOR EACH ROW
WHEN (NEW.type = 'Email' AND NEW.direction = 'OUTBOUND' AND NEW.status = 'PENDING')
EXECUTE FUNCTION public.on_communication_created();

-- 2. Webhook for Appointments -> Google Calendar Sync
CREATE OR REPLACE FUNCTION public.on_appointment_changes()
RETURNS TRIGGER LANGUAGE plpgsql
SECURITY DEFINER AS $$
BEGIN
  PERFORM net.http_post(
    url := 'https://nmrnbwnyivxktbjukspu.supabase.co/functions/v1/sync-appointment'::text,
    headers := '{"Content-Type": "application/json"}'::jsonb,
    body := jsonb_build_object(
      'type', TG_OP,
      'table', TG_TABLE_NAME,
      'schema', TG_TABLE_SCHEMA,
      'record', CASE WHEN TG_OP = 'DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END,
      'old_record', CASE WHEN TG_OP = 'UPDATE' THEN to_jsonb(OLD) ELSE NULL END
    )
  );
  RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$;

DROP TRIGGER IF EXISTS on_appointment_changes_trigger ON public.appointments;
CREATE TRIGGER on_appointment_changes_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.appointments
FOR EACH ROW
EXECUTE FUNCTION public.on_appointment_changes();

-- 3. Webhook for Clients -> Google Contacts Sync
CREATE OR REPLACE FUNCTION public.on_client_changes()
RETURNS TRIGGER LANGUAGE plpgsql
SECURITY DEFINER AS $$
BEGIN
  PERFORM net.http_post(
    url := 'https://nmrnbwnyivxktbjukspu.supabase.co/functions/v1/sync-contact'::text,
    headers := '{"Content-Type": "application/json"}'::jsonb,
    body := jsonb_build_object(
      'type', TG_OP,
      'table', TG_TABLE_NAME,
      'schema', TG_TABLE_SCHEMA,
      'record', CASE WHEN TG_OP = 'DELETE' THEN to_jsonb(OLD) ELSE to_jsonb(NEW) END,
      'old_record', CASE WHEN TG_OP = 'UPDATE' THEN to_jsonb(OLD) ELSE NULL END
    )
  );
  RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;
$$;

DROP TRIGGER IF EXISTS on_client_changes_trigger ON public.clients;
CREATE TRIGGER on_client_changes_trigger
AFTER INSERT OR UPDATE OR DELETE ON public.clients
FOR EACH ROW
EXECUTE FUNCTION public.on_client_changes();

-- Enable RLS and set policies for requests to allow public/anon insert, select, and update
ALTER TABLE public.requests ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public access to requests" ON public.requests;
CREATE POLICY "Allow public access to requests" 
ON public.requests 
TO public 
USING (true) 
WITH CHECK (true);

-- Enable RLS and set policies for organizations
ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public access to organizations" ON public.organizations;
CREATE POLICY "Allow public access to organizations" 
ON public.organizations 
TO public 
USING (true) 
WITH CHECK (true);

-- Enable RLS and set policies for settings
ALTER TABLE public.settings ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public access to settings" ON public.settings;
CREATE POLICY "Allow public access to settings" 
ON public.settings 
TO public 
USING (true) 
WITH CHECK (true);

-- Enable RLS and set policies for users
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public access to users" ON public.users;
CREATE POLICY "Allow public access to users" 
ON public.users 
TO public 
USING (true) 
WITH CHECK (true);
