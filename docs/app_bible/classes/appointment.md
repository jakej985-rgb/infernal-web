# Appointment

## Purpose

Represents a scheduled session in the shop (tattoo session, piercing service, consultation, or time block/block-off), known as a **Ritual**. This serves as the main temporal event in the studio calendar.

## Responsibilities

* Persist date, duration, pricing structure, and notes for a specific calendar event.
* Relate a customer (Soul) and a staff member (Artist) to a concrete, time-delimited appointment.
* Classify the current booking status (e.g., Scheduled, In Progress, Completed, Cancelled, No Show, or Waitlist / "Purgatory").

## Properties

* `id` (`int`): Primary identification number.
* `syncId` (`String`): Globally unique identifier for offline-first replication.
* `clientId` (`int`): Foreign key identifying the associated `Client` (Soul).
* `userId` (`int`): Foreign key identifying the associated `User` (Artist).
* `clientName` (`String`): Denormalized client name for quick calendar rendering without database joins.
* `dateTime` (`DateTime`): Start timestamp of the session (UTC).
* `durationMinutes` (`int`): Duration of the session in minutes.
* `serviceType` (`String`): Type of service (e.g., "Tattoo", "Piercing", "Touch-Up", "Consultation", etc.).
* `serviceCategory` (`String`): Service category grouping (defaults to "General").
* `priceType` (`String`): Pricing method applied (e.g., "Hourly", "Flat", "Session", "Quoted").
* `priceCharged` (`double`): Numerical price amount charged to the client.
* `quotedPrice` (`double?`): Original price estimate recorded for the booking.
* `finalPrice` (`double?`): Finalized actual price charged upon ritual completion.
* `notes` (`String?`): Free-form scheduling details, placement directions, or design descriptions.
* `photoPath` (`String?`): File path to a design reference, stencil sketch, or final photo.
* `color` (`String`): Custom calendar display color (hex format or named key).
* `status` (`String`): Active state of the appointment (e.g., "Scheduled", "InProgress", "Completed", "Cancelled", "NoShow", "Waitlist").
* `isBlockOff` (`bool`): Boolean flag stating whether this is a personal time-block rather than a client appointment.
* `lastModifiedUtc` (`DateTime`): Timestamp of the last local update (UTC).
* `lastModifiedBy` (`String`): Identifying tag of the user/system that executed the last update.
* `isDeleted` (`bool`): Soft-delete flag utilized for synchronization compatibility.

## Methods

### Commands

* `Appointment.fromJson(Map<String, dynamic> json)`: Reconstructs an appointment instance from JSON.

### Queries

* `endTime` (`DateTime`): Computed query returning the start `dateTime` offset by `durationMinutes`.
* `artistId` (`int`): Alias for `userId` (backward compatibility).
* `startTime` (`DateTime`): Alias for `dateTime` (backward compatibility).
* `statusEnum` (`AppointmentStatus`): Parses the persistent `status` text string and returns the matching typed enum state, handling string variations (e.g., "purgatory" mapped to `AppointmentStatus.waitlist`).
* `toJson()` (`Map<String, dynamic>`): Serializes the appointment instance.

## Validation Rules

* `durationMinutes` must be greater than zero.
* If `isBlockOff` is `false`, `clientId` must point to a valid registered Client.
* `dateTime` must not fall in the past during creation (except for manual historical log entries).
* `priceCharged` must be greater than or equal to zero.

## Relationships

### Owns

* **Session Photos & Stencils** (`photoPath`): Direct image reference representing work in progress or stencils.

### Owned By

* **Client** (`Client`): Relates back to the parent Client (Soul) who booked the session.
* **Artist** (`User`): Belongs to the schedule of the specific Artist conducting the ritual.

### Uses

* **AppointmentStatus** (`Enum`): Evaluation category defining calendar and billing progression.
* **ServiceType** (`Enum`): Denotes tattooing, piercing, or other services.
* **PriceType** (`Enum`): Dictates whether pricing is hourly, flat, or quoted.

### Used By

* **ClientLifecycle** (`ClientLifecycle`): Inspects historical appointment occurrences to derive if a client is Active.
* **Omens and Reports** (`OmensFeature`): Inspects completion statistics and price values to aggregate revenue.
