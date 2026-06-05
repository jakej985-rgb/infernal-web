#!/usr/bin/env python3
import json
import subprocess
import sys
import urllib.request
import urllib.error

def get_gcloud_config():
    try:
        project = subprocess.check_output(['gcloud', 'config', 'get-value', 'project']).decode('utf-8').strip()
        token = subprocess.check_output(['gcloud', 'auth', 'print-access-token']).decode('utf-8').strip()
        return project, token
    except Exception as e:
        print(f"Error running gcloud. Please ensure you are logged in using 'gcloud auth login': {e}")
        sys.exit(1)

def make_firestore_request(project_id, token, relative_path, document_id, fields):
    url = f"https://firestore.googleapis.com/v1/projects/{project_id}/databases/(default)/documents/{relative_path}?documentId={document_id}"
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json"
    }
    data = json.dumps({"fields": fields}).encode('utf-8')
    req = urllib.request.Request(url, data=data, headers=headers, method='POST')
    
    try:
        with urllib.request.urlopen(req) as response:
            return json.loads(response.read().decode('utf-8'))
    except urllib.error.HTTPError as e:
        # If it already exists, let's try PATCH (update) instead
        if e.code == 409: # Conflict / Already exists
            patch_url = f"https://firestore.googleapis.com/v1/projects/{project_id}/databases/(default)/documents/{relative_path}/{document_id}"
            req_patch = urllib.request.Request(patch_url, data=data, headers=headers, method='PATCH')
            try:
                with urllib.request.urlopen(req_patch) as resp:
                    return json.loads(resp.read().decode('utf-8'))
            except Exception as patch_err:
                print(f"Failed to update existing document: {patch_err}")
                raise patch_err
        else:
            print(f"HTTP Error {e.code}: {e.read().decode('utf-8')}")
            raise e

def main():
    print("=== Multi-Tenant Organization Setup Script ===")
    project_id, token = get_gcloud_config()
    print(f"Using GCP Project: {project_id}\n")

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

    admin_uid = input("Enter Admin User UID (from Firebase Auth Console): ").strip()
    if not admin_uid:
        print("Admin UID is required. Please create the user in your Firebase Console first.")
        return

    print("\nSetting up organization in Firestore...")

    try:
        # 1. Create Organization doc
        make_firestore_request(
            project_id, token,
            relative_path="",
            document_id=org_id,
            fields={
                "name": {"stringValue": org_name}
            }
        )
        print(f"✓ Organization document created: /organizations/{org_id}")

        # 2. Create Global user mapping
        make_firestore_request(
            project_id, token,
            relative_path="users",
            document_id=admin_uid,
            fields={
                "email": {"stringValue": admin_email},
                "orgId": {"stringValue": org_id}
            }
        )
        print(f"✓ Global mapping created: /users/{admin_uid} -> {org_id}")

        # 3. Create Org-specific admin user profile
        make_firestore_request(
            project_id, token,
            relative_path=f"organizations/{org_id}/users",
            document_id=admin_uid,
            fields={
                "email": {"stringValue": admin_email},
                "displayName": {"stringValue": admin_name},
                "role": {"stringValue": "admin"},
                "hourlyRate": {"doubleValue": 150.0},
                "isDeleted": {"booleanValue": False}
            }
        )
        print(f"✓ Org profile created: /organizations/{org_id}/users/{admin_uid}")

        # 4. Create default settings
        make_firestore_request(
            project_id, token,
            relative_path=f"organizations/{org_id}/settings",
            document_id="main",
            fields={
                "settings": {
                    "mapValue": {
                        "fields": {
                            "shopName": {"stringValue": org_name},
                            "logoPath": {"stringValue": ""},
                            "accentColor": {"stringValue": "#FF0000"},
                            "depositType": {"stringValue": "percentage"},
                            "depositAmount": {"doubleValue": 20.0},
                            "tattooPerHour": {"doubleValue": 150.0},
                            "piercingSingle": {"doubleValue": 50.0},
                            "piercingMulti": {"doubleValue": 80.0},
                            "shopMinimumRate": {"doubleValue": 80.0},
                            "taxRate": {"doubleValue": 0.08}
                        }
                    }
                }
            }
        )
        print(f"✓ Default settings initialized: /organizations/{org_id}/settings/main")

        print("\n🎉 Success! New organization has been fully initialized.")
        print(f"The admin user ({admin_email}) can now log in and manage the '{org_name}' organization.")

    except Exception as e:
        print(f"\n❌ Error setting up organization: {e}")

if __name__ == '__main__':
    main()
