# User

## Purpose

Represents an authenticated staff member of the studio, who may operate under the role of either **Admin** or **Artist**. A User handles studio setup, executes scheduling rituals, builds estimates, and configures their own UI preferences.

## Responsibilities

* Store authentication credentials securely (local BCrypt hashing).
* Manage individual artist details (hourly pricing rates, speed factors, commission tiers).
* Persist user-specific application choices (theming selections, custom fonts, keyboard shortcut mappings, permission nodes).

## Properties

* `id` (`int`): Primary identification number.
* `username` (`String`): Globally unique login handle.
* `email` (`String`): User's registration email address.
* `displayName` (`String`): Friendly display name for screens and timelines.
* `orgId` (`String`): Identifier for separating multiple clinics/shops in multi-tenant installations.
* `passwordHash` (`String`): Hashed password text generated via BCrypt algorithm.
* `role` (`UserRole`): System authority tier (`admin` or `artist`).
* `themeKey` (`String`): Key of the active user-selected color palette.
* `avatarPath` (`String`): File storage path to the user's profile image.
* `hourlyRate` (`double`): Base pricing rate charged per hour of tattooing (defaults to $150.0).
* `speedFactor` (`double`): Work efficiency coefficient (e.g., 1.2 represents a faster tattoo speed that affects quote calculations).
* `createdAt` (`DateTime`): Timestamp when this user account was generated.
* `updatedAt` (`DateTime`): Timestamp of the last local update.
* `lastLoginAt` (`DateTime?`): Optional timestamp of the user's last successful login session.
* `isActive` (`bool`): Toggle representing whether the account is currently authorized to log in.
* `isDeleted` (`bool`): Soft-delete flag utilized for synchronization compatibility.
* `deletedAt` (`DateTime?`): Optional timestamp of account deletion.
* `department` (`String`): Text designation of professional focus (e.g., Tattooing, Piercing).
* `commissionRate` (`double`): Percentage share of appointment prices paid to this user (0.0 to 1.0).
* `fontSize` (`int`): Font scale configuration preference (defaults to 14).
* `keyboardShortcutsJson` (`String`): Stored JSON listing key-action bindings.
* `permissionsJson` (`String`): Stored JSON listing granular feature permission toggles.

## Methods

### Commands

* `User.fromJson(Map<String, dynamic> json)`: Reconstructs a user record from a persistent JSON map.

### Queries

* `isAdmin` (`bool`): Returns `true` if the user's role is `UserRole.admin`.
* `effectiveDisplayName` (`String`): Returns the user's customized `displayName` if set, otherwise falls back to their unique `username`.
* `toJson()` (`Map<String, dynamic>`): Serializes the user record into JSON format.

## Validation Rules

* `username` is mandatory, must be unique, and cannot contain whitespace.
* `hourlyRate` must be greater than or equal to zero.
* `speedFactor` must be greater than zero.
* `commissionRate` must range from `0.0` to `1.0` inclusive.

## Relationships

### Owns

* This class directly owns its personal settings configuration and profile assets, but does not strictly "own" shared data collections.

### Owned By

* **Studio Registry**: Stored within the SQLite user ledger under system administration.

### Uses

* **UserRole** (`Enum`): Denotes whether authority limits correspond to Administrator or Artist boundaries.

### Used By

* **Appointment** (`Appointment`): Identifies the Artist scheduled to conduct the session.
* **Quote** (`Quote`): Identifies the Artist who drafted the custom price estimate.
* **Document** (`Document`): Audits which user performed the file upload.
* **AuditLog** (`AuditLog`): Identifies the staff member who triggered a specific ledger event.
