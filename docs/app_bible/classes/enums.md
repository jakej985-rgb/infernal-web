# Domain Enums

This document serves as the repository of truth for all domain-level enumerations used in the **Infernal Ink & Steel Suite**. Enums represent strongly-typed categorization and boundaries across business workflows, keeping them clean of magic strings and persistent SQL concerns.

---

## ClientStatus

### Purpose — ClientStatus

Categorizes a customer's active lifecycle phase and standing in the studio ledger. This categorization drives dynamic UI highlights, visual styling (such as colored card glows), and targeted marketing or booking outreach.

### Values — ClientStatus

* `bound`: Standard regular patrons of the studio with multiple successful appointments.
* `freshSoul`: Brand new clients with either zero or one completed bookings. Shows special onboarding tooltips.
* `highValue`: VIP clients with exceptionally high visit counts or total spend. Represented with gilded, glowing borders.
* `void_`: Blacklisted, blocked, or banned customers. Red-flagged profiles preventing scheduling commands.

### Methods — ClientStatus

#### Queries — ClientStatus

* `String get label`: Returns a capitalized, readable string presentation (e.g., "Fresh Soul", "High Value", "Bound", "Void").
* `String get themeColorHex`: Returns the Neon-Infernal theme color code associated with the status (e.g., Gold for High Value, Blood Red for Void).

---

## UserRole

### Purpose — UserRole

Defines system access boundaries and role-based permissions for studio staff members.

### Values — UserRole

* `artist`: Professional tattoo artist or body piercer. Permissions are limited to scheduling their own calendar bookings, checking their personal quotes, managing active stencils, and viewing their performance metrics.
* `admin`: Studio administrator or owner. Grants full, unrestricted permissions to edit global configurations, modify operating hours, manage the entire roster of artists, overwrite inventory items, view financial reports, and inspect the system audit logs.

### Methods — UserRole

#### Queries — UserRole

* `bool get isAdmin`: Syntactic query shortcut returning `true` if role is `admin`.
* `bool get isArtist`: Syntactic query shortcut returning `true` if role is `artist`.

---

## AppointmentStatus

### Purpose — AppointmentStatus

Dictates the progressive operational state of a scheduled calendar session (Ritual) from booking to completion or cancellation.

### Values — AppointmentStatus

* `scheduled`: Future booking confirmed on the calendar.
* `inProgress`: Session is currently underway in the artist's booth.
* `completed`: The ritual has finished, and payment checkout is complete.
* `cancelled`: Session was cancelled prior to starting.
* `noShow`: The client failed to show up without cancelling.
* `waitlist` (conceptually *Purgatory*): Session in the queue, awaiting scheduling or cancellation openings.

### Methods — AppointmentStatus

#### Queries — AppointmentStatus

* `bool get isActive`: Returns `true` if the status is `scheduled` or `inProgress`.
* `bool get isFinal`: Returns `true` if the status is `completed`, `cancelled`, or `noShow` (cannot be further modified).

---

## ServiceType

### Purpose — ServiceType

Denotes the primary category of physical work performed during an appointment slot.

### Values — ServiceType

* `tattoo`: Professional custom ink application.
* `piercing`: Body piercing or piercing jewelry insertion.
* `consultation`: Design, stencil, scaling, and scheduling discussion session.
* `touchUp`: Restorative ink layer, often discounted or free within warranty periods.

---

## PriceType

### Purpose — PriceType

Specifies the calculation and billing strategy applied to an appointment or quote.

### Values — PriceType

* `hourly`: Price calculated by multiplying the duration by the artist's or shop's hourly rate.
* `flat`: Constant fixed pricing for simple or predefined items.
* `session`: Fixed price per day-session or sitting, regardless of exact duration.
* `quoted`: Dynamic price pulled from the custom Quote Estimator algorithm.

---

## DepositType

### Purpose — DepositType

Dictates how booking deposits are calculated during quote and scheduling workflows.

### Values — DepositType

* `percentage`: Deposit is a percentage fraction (e.g., 20%) of the total booking price.
* `fixed`: Deposit is a standard fixed cash amount (e.g., $100.0).

---

## Validation Rules

* Enum strings read from database files or serialized JSON must map strictly to valid lower-camel-case or exact matching identifiers. Any unknown values default gracefully (e.g., `ClientStatus` defaults to `freshSoul`, `AppointmentStatus` defaults to `waitlist`).

---

## Relationships

* **Used By**:
  * [Client](./client.md) uses `ClientStatus`
  * [User](./user.md) uses `UserRole`
  * [Appointment](./appointment.md) uses `AppointmentStatus`, `ServiceType`, and `PriceType`
  * [ShopSettings](./shop_settings.md) uses `DepositType`
  * [Quote](./quote.md) uses `ServiceType` and `PriceType`
