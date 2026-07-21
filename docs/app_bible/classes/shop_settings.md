# ShopSettings

## Purpose

Represents global administrative rules, pricing standards, visual branding paths, operating hours, and customer notification preferences for the studio. It acts as a singleton configuration row in local storage.

## Responsibilities

* Houses fundamental business parameters (hourly rates, piercing fees, tax scales, and shop minimums).
* Dictates active UI/UX preferences (logo locations, fonts, color palettes, and sidebar illustrations).
* Sets scheduling constraints (operating hours, deposit splits, and buffer times).
* Computes pricing formulas (calculating deposits and pricing with sales tax).

## Properties

### 1. Global Configuration (`ShopSettings`)

* `id` (`int`): Primary domain identifier (typically defaults to `-1` for singleton persistence representation).
* `shopName` (`String`): Descriptive display name of the tattoo studio.
* `logoPath` (`String`): File storage path to the studio's branding logo.
* `accentColor` (`String`): Hex representation of the primary brand color.
* `sidebarArtworkPath` (`String`): Image path of the sidebar background illustration.
* `specialMessageText` (`String`): Specific text message shown for general announcements.
* `loginBackgroundPath` (`String`): File path to the custom login screen background.
* `loginHeadlineFontFamily` (`String`): Font family selector for the login screen.
* `loginTaglineFontFamily` (`String`): Font family selector for the login subtitle.
* `loginTextColor` (`String`): Hex representation of login screen text color.
* `tattooPerHour` (`double`): Standard billing rate charged per hour of tattooing (defaults to $150.0).
* `piercingSingle` (`double`): Fee charged for a single piercing session (defaults to $50.0).
* `piercingMulti` (`double`): Discounted per-piercing fee charged for multiple piercings (defaults to $40.0).
* `shopMinimumRate` (`double`): Absolute minimum rate applied to any active session (defaults to $100.0).
* `enableAutomaticHolidayThemes` (`bool`): Toggle indicating if holiday color maps trigger automatically.
* `isSpecialMessageEnabled` (`bool`): Toggle representing if the active special message text renders in the application.
* `shopHoursJson` (`String`): JSON string array mapping the operational [ShopDaySetting](#2-daily-operating-hours-shopdaysetting) schedules for each day.
* `taxRate` (`double`): Sales tax multiplier represented as a decimal fraction (e.g., 0.08 represents 8%).
* `depositType` (`DepositType`): Category determining deposit calculations (`percentage` or `fixed`).
* `depositAmount` (`double`): Standard requirement value for bookings (either fixed dollar or percentage points).
* `bookingBufferMinutes` (`int`): Mandatory buffer duration in minutes inserted between consecutive appointments.
* `cancellationPolicy` (`String`): Text details of the studio's cancellation and deposit forfeiture policy.
* `appointmentDurationPresetsJson` (`String`): Stored JSON list of duration interval options.
* `specialHoursJson` (`String`): Stored JSON listing special studio operating hours or holiday closures.
* `notificationSettingsJson` (`String`): Stored JSON parameters for reminder pathways.
* `backupSettingsJson` (`String`): Stored JSON configurations for backup intervals and pathways.
* `linkedAccountsJson` (`String`): Stored JSON detailing integration access nodes.
* `appFontSize` (`double`): Base font scaling parameter used across layouts (defaults to 14.0).
* `createdAt` (`DateTime`): Timestamp when the shop registry record was created.
* `updatedAt` (`DateTime`): Timestamp of the last local update.

### 2. Daily Operating Hours (`ShopDaySetting`)

* `dayOfWeek` (`int`): Integer representation of weekday (1=Monday, 7=Sunday).
* `isOpen` (`bool`): Boolean flag noting if the studio allows bookings on this day.
* `startTimeMinutes` (`int`): Operational opening time expressed in minutes from midnight (defaults to 540, representing 9:00 AM).
* `endTimeMinutes` (`int`): Operational closing time expressed in minutes from midnight (defaults to 1080, representing 6:00 PM).

---

## Methods

### Commands

* `ShopSettings.fromJson(Map<String, dynamic> json)`: Reconstructs the singleton instance from JSON.
* `ShopDaySetting.fromJson(Map<String, dynamic> json)`: Reconstructs a single weekday schedule from JSON.

### Queries

* `double calculateDeposit(double price)`: Dynamic query calculating deposit requirements based on the active `depositType` structure.
  * For `DepositType.percentage`, returns `price * (depositAmount / 100)`.
  * For `DepositType.fixed`, returns `depositAmount`.
* `double calculateWithTax(double price)`: Returns the calculated total billing value offset by the current decimal `taxRate` (`price * (1 + taxRate)`).
* `Duration get startTime` (`ShopDaySetting` query): Returns starting minutes converted into a standard `Duration` offset.
* `Duration get endTime` (`ShopDaySetting` query): Returns closing minutes converted into a standard `Duration` offset.
* `String get startTimeFormatted` (`ShopDaySetting` query): Returns 24-hour formatted string representation of start time (e.g., "09:00").
* `String get endTimeFormatted` (`ShopDaySetting` query): Returns 24-hour formatted string representation of end time (e.g., "18:00").
* `toJson()` (`Map<String, dynamic>`): Serializes configuration matrices.

---

## Validation Rules

* **Taxes & Prices**: Tax rate must be a decimal between 0.0 and 1.0. All price, rate, and minimum fields must be non-negative.
* **Operating Hours**: Start minutes must occur before closing minutes on any active day. Weekday representation must fall within the range of 1 to 7 inclusive.

---

## Relationships

### Owns

* **Operating Schedule** (`shopHoursJson`): Set of customized weekday timing boundaries.

### Owned By

* **Studio Workgroup**: Stored globally as the primary setup matrix.

### Uses

* [DepositType](./enums.md)

### Used By

* [Smart Quote Calculator](../features/quotes.md) (Inspects standard rates, minimums, and tax settings to compile ranges)
* [Rituals Scheduler](../features/appointments.md) (Inspects operating hours and buffer times during calendar allocation)
* [Settings Screen](../screens/settings_screens.md) (Read and written by setup screens)

---

## Future Expansion

* **Multi-Location Shops**: Refactoring the configuration from a singleton into an active multi-row registry, mapping unique schedules and tax rates to multiple business locations.
* **Holiday Autopilot Profiles**: Visual interface matching specific calendar holidays with themed accent colors dynamically.

---

## Open Questions

* Should we expand `shopHoursJson` from minutes-from-midnight integers to standard serialized duration segments? (Currently kept as minutes for database parsing speed).
