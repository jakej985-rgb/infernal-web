# ClientLifecycle

## Purpose

A domain behavior utility designed to dynamically calculate the engagement status (lifecycle state) of a Client based on actual historical scheduling data. This separates pure database state from operational business rules.

## Responsibilities

* Derive a client's lifecycle label dynamically instead of relying purely on an immutable database enum.
* Evaluate client activity over time, classifying them as New, Active, or Inactive based on actual completed visits.
* Establish precise thresholds (e.g., 7 days for new clients, 2 years for active status) for client engagement categorization.

## Properties

This is a utility domain module rather than an instantiable record class, so it does not contain persistent fields. However, the evaluation yields:

* `ClientLifecycleLabel` (`Enum`): Result label representing the derived engagement tier:
  * `newClient` (Display name: 'New'): Client was registered within the last 7 days.
  * `active` (Display name: 'Active'): Client has had at least one completed, non-deleted appointment ritual within the last 2 years.
  * `inactive` (Display name: 'Inactive'): Client has no completed rituals within the last 2 years, or has never had a completed ritual (and registration is older than 7 days).

## Methods

### Commands

This module contains no state-altering commands, ensuring complete preservation of data purity.

### Queries

* `deriveClientLifecycle({required Client client, required Iterable<Appointment> appointments, required DateTime now})` (`ClientLifecycleLabel`): Evaluate and return the derived status of a client at a specific point in time (`now`).

## Validation Rules

* The evaluated list of `appointments` must filter out any soft-deleted records (`isDeleted == true`) before performing lifecycle analysis.
* The evaluation must check that the client's `createdAt` timestamp is not in the future relative to the reference `now` timestamp.

## Relationships

### Owns

* This class is a stateless service and owns no sub-entities.

### Owned By

* The domain layers of the application. It acts as a shared domain helper.

### Uses

* **Client** (`Client`): Inspects the `id` and `createdAt` properties to anchor the calculation.
* **Appointment** (`Appointment`): Inspects historical appointment start dates, deleted states, and completion statuses.

### Used By

* **Clients Feature** (`ClientsFeature`): Used to render status indicators and badge labels dynamically on list and detail views.
* **Reports and Omens** (`OmensFeature`): Used to aggregate total active versus inactive souls in studio dashboards.

## Future Expansion

* **High Value Soul Tier**: Introduce an automated "High Value" status for clients with more than 10 completed rituals or total spend exceeding a configurable shop limit.
* **Vulnerable Soul Warning**: Flag active clients whose 2-year deadline is approaching within the next 30 days, suggesting proactive outbound booking outreach.

## Open Questions

* Should the 7-day registration window and the 2-year inactivity threshold be configurable via `ShopSettings`? (Currently hardcoded inside the domain file).
