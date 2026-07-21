# CommunicationRitual

## Purpose

Represents a recorded transaction of a messaging exchange between the studio and a client (such as appointment reminder SMS, post-care instruction emails, confirmation notices, or general broadcast campaigns), known as a **Signal Log** or **Communication Treaty**.

## Responsibilities

* Persist a clear record of message exchanges, tracking the dispatch timestamp, content, delivery pathway, and directionality (inbound vs. outbound).
* Maintain delivery status flags (Pending, Sent, Failed) to handle communications and sync queues.
* Associate messages with a Client directory or identify them as standalone alerts.

## Properties

* `id` (`int`): Primary domain identification key.
* `syncId` (`String`): Globally unique identifier (UUID) for offline-first replication.
* `clientId` (`int?`): Optional foreign key to the targeted [Client](./client.md) (can be null for unregistered contacts).
* `clientName` (`String`): Stored/denormalized recipient name for rapid log displays.
* `type` (`String`): Gateway pathway used (e.g., `"SMS"`, `"Email"`, `"System"`).
* `direction` (`String`): Direction of transmission relative to the shop (`"INBOUND"` or `"OUTBOUND"`).
* `content` (`String`): Entire string contents of the body text or message payload.
* `sentAt` (`DateTime`): Timestamp tracking when the message was dispatched or logged.
* `status` (`String`): Transaction delivery state (`"PENDING"`, `"SENT"`, `"FAILED"`).
* `lastModifiedUtc` (`DateTime?`): Optional timestamp tracking the last change of state (UTC).
* `lastModifiedBy` (`String`): Log identifier auditing the modifier user or daemon thread.
* `isDeleted` (`bool`): Soft-delete flag utilized for synchronization compatibility.

## Methods

### Commands

* `CommunicationRitual.fromJson(Map<String, dynamic> json)`: Reconstructs a CommunicationRitual instance from persistent JSON.

### Queries

* `toJson()` (`Map<String, dynamic>`): Serializes message metadata to a standard JSON map.

## Validation Rules

* `content` and `clientName` must contain at least one non-whitespace character.
* `type` must correspond to supported channels (SMS, Email, System).
* `direction` must equal either `"INBOUND"` or `"OUTBOUND"`.

## Relationships

### Owns

None. Exists as an immutable log event.

### Owned By

* **Client** ([Client](./client.md)): Linked directly to the target Client profile receiving the notification.

### Uses

* **Notification Channels**: Interacts with physical device services or local integration APIs to execute message routing.

### Used By

* **Communications Feature** (`CommunicationsService`): Dispatches transaction signals and captures receipt indicators.
* **Communications Ledger Screen** (`CommunicationsScreens`): Renders complete messaging timelines, notification templates, and retry panels for failed transmissions.
