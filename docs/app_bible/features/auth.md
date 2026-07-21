# Feature — Authentication & Session Management

## Purpose

Enables staff members to securely log into their local profiles without requiring an active internet connection (offline-first). This feature supports role-based permissions (Admin vs. Artist), ensuring strict data access controls within the local SQLite instance.

## User Flow

1. **Startup**: The user launches the application. If a valid, non-expired local session token exists, they bypass login and land directly on "The Altar" (Dashboard).
2. **Splash/Login Screen**: If no session is active, the app displays the dark, themed login splash containing fields for username and password.
3. **Form Entry**: The user inputs their unique username and plaintext password.
4. **Validation and Hashing**: The system fetches the local User record, matches usernames, hashes the input password via local BCrypt, and compares it against the stored `passwordHash`.
5. **Session Initiation**: On a successful match, the user's role is established, `lastLoginAt` is updated, and the router transitions them to `/dashboard`.
6. **Demo Bootstrap**: A dedicated quick-boot trigger exists on the login panel to seed a default Administrator and sample Artists on a fresh installation.

## Classes Used

* **User** ([User](../classes/user.md)): Holds account data, credentials, and settings.
* **UserRole** ([UserRole](../classes/enums.md)): Enumerates system authorization boundaries.

## Commands

* `initializeDemoAdmin()`: Seeds a default Admin user (`admin`/`admin123`) into the local SQLite database.
* `login(String username, String password)`: Validates credentials, sets the active global session state, and logs the login event in system audit logs.
* `logout()`: Clears the current memory session token, resetting the app router back to the `/login` node.

## Queries

* `isAuthenticated()` (`bool`): Evaluates whether a current active user session is present in memory.
* `currentUser()` (`User?`): Returns the active logged-in User instance.
* `hasPermission(String node)` (`bool`): Inspects the permissions schema on the current user to verify if they are authorized to trigger a specific operation.

## Validation

* Username must not contain whitespace and cannot be empty.
* Plaintext password entry must match complexity requirements during profile setup (length >= 6).
* The active local user status must be `isActive == true` and `isDeleted == false` to allow authentication.

## Edge Cases

* **Missing Default Profiles**: On a brand new database installation, no users exist. The login screen safely catches this and displays a quick-action banner to "Initialize Demo Data" to bypass blockages.
* **Deactivated Artists**: If an admin soft-deletes or marks an artist profile as inactive while that artist has a running app instance, their local session is invalidated on the next database check-in, forcing them back to the login wall.

## Future Ideas

* **Biometric Auth**: Fingerprint and face unlocks on mobile tablets utilizing standard local platform APIs.
* **Offline PIN Code**: Rapid 4-digit PIN locks for active sessions during fast-paced studio operations.
