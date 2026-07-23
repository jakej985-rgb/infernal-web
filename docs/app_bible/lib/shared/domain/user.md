# Code Chronicle — user.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/user.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
User entity matching legacy Domain/User.cs Represents an artist or admin in the tattoo shop system. Primary key Unique login username User email address Display name for UI Organization ID for multi-tenant isolation Hashed password (BCrypt) User role (Admin/Artist) UI theme preference key Path to avatar image Default hourly rate Work speed multiplier Account creation timestamp Last update timestamp Last login timestamp Whether account is active Soft delete flag Deletion timestamp Department assignment Commission rate (0-1, e.g., 0.1 = 10%) UI font size preference JSON string for keyboard shortcuts JSON string for permissions Private constructor for custom getters Check if user is an admin Get effective display name (falls back to username) Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`
* `enums.dart`

---

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
