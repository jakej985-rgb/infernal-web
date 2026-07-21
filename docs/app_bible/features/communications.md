# Feature — Communications Log ("The Signal Ledger")

## Purpose

Logs outward communications (SMS notifications, post-care instruction emails, and manual client interactions) sent from the shop. It allows artists and shop managers to keep an audit log of client notifications and confirm text arrivals.

## User Flow

1. **Directory Loading**: The user opens the Communications ledger, viewing a list of recent messages with tags showing delivery type (SMS, Email, System) and status (Pending, Sent, Failed).
2. **Reviewing Logs**: Selecting an item opens a slide panel showing the complete text body, exact timestamp, recipient name, and direction.
3. **Drafting Messages**: The user can open a standard text form, select a Client, pick a messaging gateway (SMS or Email), insert canned template texts, and click "Send".
4. **Retry Triggering**: If a delivery status lists as "Failed", the user can tap an active "Retry" action button to trigger dispatch pipelines again.

## Classes Used

* **CommunicationRitual** ([CommunicationRitual](../classes/communication.md)): Core domain entity modeling a recorded text transition.
* **Client** ([Client](../classes/client.md)): Target recipient profile.

## Commands

* `logCommunication(CommunicationRitual msg)`: Records a fresh message entry in SQLite tables.
* `updateMessageStatus(int id, String status)`: Modifies delivery flags (e.g., changes `"PENDING"` to `"SENT"` or `"FAILED"`).
* `dispatchMessage(int id)`: Executes API connections with external notification gateways.

## Queries

* `getCommunicationsStream()` (`Stream<List<CommunicationRitual>>`): Streams reactive collections of message logs.
* `getMessagesForClient(int clientId)` (`Future<List<CommunicationRitual>>`): Returns history folders of communications for a specified Client.

## Validation

* Content strings cannot be empty.
* Recipients must contain either a registered phone number (for SMS routing) or email address (for Email dispatching).

## Edge Cases

* **Gateway Failures**: If external SMS or SMTP services throw exceptions (e.g., cell network down, invalid email servers), the database captures the event by marking status as `"FAILED"` and logging details in the audit ledger, keeping the client form active for retries.

## Future Ideas

* **Automated Aftercare Rituals**: Automatically scheduling a sequence of helpful post-care instruction texts to fire 3, 7, and 14 days after a tattoo marked as "Completed".
* **Rich Notification Templates**: Rich HTML/CSS templates for emailing stylized newsletters and portfolio updates.
