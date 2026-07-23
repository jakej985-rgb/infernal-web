# Code Chronicle — shop_settings.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/shop_settings.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
ShopSettings entity matching legacy Domain/ShopSettings.cs Global shop configuration settings (singleton row in database). Primary key (typically -1 for singleton) Shop name for display Path to logo image Primary accent color (hex or named) Path to sidebar artwork Special message text for announcements Path to login background image Login headline font family Login tagline font family Login text color Tattoo hourly rate Single piercing price Multiple piercing discount price Shop minimum charge Whether to enable automatic holiday themes Whether special message is enabled JSON string for shop hours by day Sales tax rate (0-1, e.g., 0.08 = 8%) Deposit type (Percentage or Fixed) Deposit amount (percentage or fixed value) Buffer minutes between bookings Cancellation policy text JSON string for appointment duration presets JSON string for special hours/closures JSON string for notification settings JSON string for backup settings JSON string for linked accounts Default app font size Record creation timestamp Last update timestamp Private constructor for custom getters Calculate deposit for a given price Calculate price with tax Create from JSON Day-specific shop hours configuration Matching legacy ShopDaySetting Day of week (1=Monday, 7=Sunday for DateTime convention) Whether shop is open this day Opening time (minutes from midnight) Closing time (minutes from midnight) Private constructor for custom getters Get start time as Duration Get end time as Duration Formatted start time string (HH:MM) Formatted end time string (HH:MM) Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`
* `enums.dart`

---

## ⚙️ Methods & Routines (CQS Boundaries)
* **`calculateDeposit()`**: Handles data retrieval queries (Query).
* **`calculateWithTax()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
