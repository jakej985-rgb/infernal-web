# Screen — Communications Hub Screen

## Purpose

Provides a central messaging ledger detailing transactional SMS and email notifications dispatched to studio clients.

## Widgets

* **Signal Log List**: Scrollable chronological list showing dispatched notifications.
* **Delivery Status Badge**: Indicates communication statuses (`PENDING`, `SENT`, `FAILED`) with color codes.
* **Template Select Sheet**: collapsible drawer showing ready-made templates.
* **Retry Action Trigger**: Tap panel to re-dispatch failed messages.

## Inputs

* Message form inputs, search filters, and template identifiers.

## Outputs

* Records communication transaction rows.
* Connects with external delivery APIs to fire texts.

## Navigation

* `/communications` → `/dashboard` (return navigation).

## Uses Classes

* **CommunicationRitual** ([CommunicationRitual](../classes/communication.md)): Direct metadata model.
* **Client** ([Client](../classes/client.md)): Recipient profile.

## States

* **Sending**: Loading overlays blocking further user submissions during dispatch checks.
* **Active**: Displays logs.
* **Empty State**: Displays clear placeholders when empty ("The signal ledger remains silent...").
* **Error State**: Flags failed message attempts with retry badges.
