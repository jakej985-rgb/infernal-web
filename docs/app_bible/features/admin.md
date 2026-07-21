# Feature — System Administration ("The Sanctum")

## Purpose

Allows administrators to manage staff rosters (Admins and Artists), set default hourly rates, de-authorize profile access, configure system settings, and inspect persistent audit records detailing database read/write modifications.

## User Flow

1. **Access Panel**: An authenticated Admin enters the Administration area.
2. **Staff Roster Management**: The user lists active profiles, tapping "Add Staff" to create or edit Artist/Admin records, configuring Display Names, Commission Rates, and default Hourly Rates.
3. **Toggle Authorization**: The admin can deactivate an artist's account instantly via toggle keys, immediately blocking their active application access on next query checks.
4. **Audit Logs Scanning**: Tapping "Audit Ledger" brings up a color-coded log list. Admins filter events by severity levels (Info, Warning, Severe) or search log text matching specific dates or users.

## Classes Used

* **User** ([User](../classes/user.md)): Core entity modeling staff accounts.
* **AuditLog** (`AuditLog`): Logging structure representing recorded ledger modifications.

## Commands

* `createUser(User user)`: Inserts a new staff profile with encrypted credentials.
* `updateUser(User user)`: Saves changes to staff details or rate multipliers.
* `deactivateUser(int id)`: Flags a profile as inactive (`isActive = false`) and logs account deactivation events.
* `purgeAuditLogs(DateTime ageCutoff)`: Truncates historical audit log entries older than selected cutoffs.

## Queries

* `getUsersList()` (`Stream<List<User>>`): Streams reactive user rosters.
* `getSystemAuditLogs()` (`Future<List<AuditLog>>`): Fetches system logging entries, supporting paginated, filtered, or text queries.

## Validation

* Usernames must be unique, non-blank, and exclude whitespace characters.
* Password credentials must satisfy minimum length constraints during profile generation.

## Edge Cases

* **Self-Deactivation Block**: The app code enforces logic preventing active admins from deactivating or soft-deleting their own profiles to prevent accidental admin-lockouts.

## Future Ideas

* **Granular Permission Trees**: Admin dashboard with checkboxes to customize precise permission matrices (e.g., allow specific artists to edit prices while blocking others) rather than standard role enums.
* **Auto-Archiving Logs**: Automatic routine exporting of completed logs to encrypted disk vaults to free local database resources.
