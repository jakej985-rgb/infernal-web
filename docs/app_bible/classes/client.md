# Client

## Purpose

Represents a customer of the studio who receives tattoos, piercings, or consultations. It serves as the ledger profile for managing history, contacts, medical/waiver documents, and progress notes.

## Responsibilities

* Houses and manages personal identity details (First Name, Middle Name, Last Name).
* Stores primary contact coordinates (Phone, Email).
* Maintains a tally of physical visits and notes.
* Holds reference coordinates for client avatar styling and soft-deletion tracking.

## Properties

* `id` (`int`): Primary domain identifier.
* `syncId` (`String`): Globally unique identifier for offline sync syncing.
* `firstName` (`String`): Client's given name.
* `middleName` (`String`): Client's middle name (optional, defaults to empty).
* `lastName` (`String`): Client's family name.
* `phone` (`String`): Phone number for communications.
* `email` (`String`): Email address for receipts, reminders, and waivers.
* `notes` (`String`): Specific notes (allergies, design ideas, or style preferences).
* `visits` (`int`): Count of completed appointments.
* `photoPath` (`String`): Storage path to the client's local avatar or portrait.
* `status` (`ClientStatus`): Active status identifier (`bound`, `freshSoul`, `highValue`, `void_`).
* `createdAt` (`DateTime`): Timestamp when the soul record was first inscribed (UTC).
* `lastModifiedUtc` (`DateTime`): Timestamp of the last local mutation (UTC).
* `lastModifiedBy` (`String`): Signature identifier of the user who last performed an edit.
* `isDeleted` (`bool`): Soft delete flag indicating whether the record is active or sent to the void.

---

## Methods

### Commands

> Note: As domain models are modeled as immutable freezed classes, "commands" result in the generation of a mutated copy.

* `Client.fromJson(Map<String, dynamic> json)`: Reconstructs a Client instance from persistent serialized maps.

### Queries

* `String get fullName`: Computes the structured full name by combining non-empty segments of `firstName`, `middleName`, and `lastName`.
* `Map<String, dynamic> toJson()`: Formats properties into persistent maps.

---

## Validation Rules

* **First & Last Name**: Must contain at least one non-whitespace character.
* **Email format**: Must conform to email layout regex standards if provided.
* **Phone format**: Must be parsed into standard telephone structure if provided.

---

## Relationships

### Owns

* [Document](./document.md) (Waivers, reference photos, consent contracts)
* [Appointment](./appointment.md) (Completed, active, or pending ritual events)
* [Quote](./quote.md) (Smart pricing estimates and calculators)

### Owned By

* The Studio (represented globally in the persistence ledger)

### Uses

* [ClientStatus](./enums.md)

### Used By

* [ClientLifecycle](./client_lifecycle.md)
* [Appointment](./appointment.md)
* [Quote](./quote.md)
* [Document](./document.md)
* [CommunicationRitual](./communication.md)

---

## Future Expansion

* **Client Portal Accounts**: Support for linked client login profiles.
* **Client Bio-Metrics**: Tracking of medical sensitivities (skin conditions, ink allergies, etc.) in a dedicated medical-specific subclass.

---

## Open Questions

* Should `visits` be computed on-the-fly from historical completed appointments rather than stored as a mutable static counter? (Currently kept as a property matching legacy design).
