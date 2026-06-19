#!/usr/bin/env python3
import json
import sys
import urllib.request
import urllib.error

def make_supabase_request(url, method, data, headers):
    encoded_data = json.dumps(data).encode('utf-8')
    req = urllib.request.Request(url, data=encoded_data, headers=headers, method=method)
    
    try:
        with urllib.request.urlopen(req) as response:
            res_content = response.read().decode('utf-8')
            return json.loads(res_content) if res_content else {}
    except urllib.error.HTTPError as e:
        err_msg = e.read().decode('utf-8')
        print(f"HTTP Error {e.code}: {err_msg}")
        raise Exception(f"Request failed: {err_msg}")

def main():
    print("=== Multi-Tenant Organization Setup Script (Supabase) ===")
    
    supabase_url = input("Enter Supabase URL (e.g. https://xxxx.supabase.co): ").strip()
    if not supabase_url:
        print("Supabase URL is required.")
        return
        
    service_role_key = input("Enter Supabase Service Role Key: ").strip()
    if not service_role_key:
        print("Service Role Key is required.")
        return

    org_id = input("Enter Organization ID (slug, e.g., 'valhalla-ink'): ").strip()
    if not org_id:
        print("Organization ID is required.")
        return

    org_name = input("Enter Organization Name (e.g., 'Valhalla Ink'): ").strip()
    if not org_name:
        print("Organization Name is required.")
        return

    admin_email = input("Enter Owner/Admin Email: ").strip()
    if not admin_email:
        print("Admin email is required.")
        return

    admin_name = input("Enter Owner/Admin Display Name: ").strip()
    if not admin_name:
        print("Admin display name is required.")
        return

    admin_uid = input("Enter Admin User UID (from Supabase Auth Console): ").strip()
    if not admin_uid:
        print("Admin UID is required. Please create the user in your Supabase Auth Console first.")
        return

    # Clean URL trailing slash
    base_url = supabase_url.rstrip('/')
    
    headers = {
        "apikey": service_role_key,
        "Authorization": f"Bearer {service_role_key}",
        "Content-Type": "application/json",
        "Prefer": "resolution=merge-duplicates"
    }

    print("\nSetting up organization in Supabase Database...")

    try:
        # 1. Create Organization row
        org_url = f"{base_url}/rest/v1/organizations"
        org_data = {
            "id": org_id,
            "name": org_name
        }
        make_supabase_request(org_url, "POST", org_data, headers)
        print(f"✓ Organization created in public.organizations: {org_id}")

        # 2. Create public.users row
        users_url = f"{base_url}/rest/v1/users"
        user_data = {
            "id": admin_uid,
            "email": admin_email,
            "display_name": admin_name,
            "username": admin_email.split('@')[0],
            "role": "admin",
            "hourly_rate": 150.0,
            "is_deleted": False,
            "org_id": org_id
        }
        make_supabase_request(users_url, "POST", user_data, headers)
        print(f"✓ Admin user created in public.users: {admin_uid} -> {org_id}")

        # 3. Create public.settings row
        settings_url = f"{base_url}/rest/v1/settings"
        settings_data = {
            "org_id": org_id,
            "shop_name": org_name,
            "logo_path": "",
            "accent_color": "#FF0000",
            "deposit_type": "percentage",
            "deposit_amount": 20.0,
            "tattoo_per_hour": 150.0,
            "piercing_single": 50.0,
            "piercing_multi": 80.0,
            "shop_minimum_rate": 80.0,
            "tax_rate": 0.08
        }
        make_supabase_request(settings_url, "POST", settings_data, headers)
        print(f"✓ Default settings initialized in public.settings for org: {org_id}")

        print("\n🎉 Success! New organization has been fully initialized in your Supabase database.")
        print(f"The admin user ({admin_email}) can now log in and manage the '{org_name}' organization.")

    except Exception as e:
        print(f"\n❌ Error setting up organization: {e}")

if __name__ == '__main__':
    main()
