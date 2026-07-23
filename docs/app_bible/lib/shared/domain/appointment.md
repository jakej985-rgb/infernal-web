# Code Chronicle — appointment.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/appointment.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Appointment entity matching legacy Domain/Appointment.cs Represents a scheduled session (tattoo, piercing, etc.) in the shop. Primary key Sync identifier for multi-device sync Foreign key to Client Foreign key to User (Artist) Denormalized client name for quick display Appointment start date/time Duration in minutes Type of service (Tattoo, Piercing, etc.) Service category grouping Pricing method (Hourly, Flat, etc.) Amount charged Original quoted price Finalized price Free-form notes Path to reference photo Calendar display color (hex or named) Current status (Scheduled, Completed, etc.) Whether this is a time block (not a real appointment) Last modification timestamp (UTC) User who last modified this record Soft delete flag Private constructor for custom getters Computed end time based on dateTime + duration Alias for userId (legacy compatibility) Alias for dateTime (legacy compatibility) Parse status string to enum Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`
* `enums.dart`

---

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
