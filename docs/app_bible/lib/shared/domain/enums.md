# Code Chronicle — enums.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/enums.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Domain enums matching the legacy C# codebase Client status matching legacy ClientStatus enum. Kept for legacy data compatibility. New client lifecycle labels are derived automatically from creation date and completed appointment history. Active client New client Legacy high-value client Archived/Inactive client Returns the human-readable display name of the status User role for authorization Maps to legacy UserRole enum Super user / Platform administrator Full access admin Artist with limited access Appointment status Derived from legacy usage patterns in AppointmentDto Scheduled but not yet started Currently in progress Successfully completed Client cancelled Client did not show up In "Purgatory" (waitlist) Service type for appointments Tattoo session Piercing service Touch-up/correction Consultation only Other service Price type for appointments Charged by the hour Fixed flat rate Session-based pricing Quoted price Deposit type for shop settings Percentage of quoted price Fixed amount

---

## ⛓️ Import Dependencies
*No external import dependencies registered.*

---

## 📊 Stored Enumerations
### `enum ClientStatus`
* Defines typed, validated operational categories for workflows.

### `enum UserRole`
* Defines typed, validated operational categories for workflows.

### `enum AppointmentStatus`
* Defines typed, validated operational categories for workflows.

### `enum ServiceType`
* Defines typed, validated operational categories for workflows.

### `enum PriceType`
* Defines typed, validated operational categories for workflows.

### `enum DepositType`
* Defines typed, validated operational categories for workflows.

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
