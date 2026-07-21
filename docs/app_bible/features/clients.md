# Feature — Clients Ledger ("The Soul Ledger")

## Purpose

Manages customer profiles, demographic details, visit metrics, and automatic engagement tracking (New, Active, Inactive labels). It provides a full, searchable directory of clients, showing details, uploaded waivers, and scheduled appointment histories.

## User Flow

1. **Browse/Search**: The user navigates to the Clients ledger. They search by first/last name, email, or telephone number, and toggle status filters.
2. **Details View**: Selecting a client presents their profile summary, contact card, automatic lifecycle badge, free-form notes, and visit count.
3. **Attachments and History**: Below the profile header, tabbed sections display historical and upcoming appointments, uploaded documents (waivers), and historical communications.
4. **Edit/Create Forms**: Tapping "Register Client" or "Edit Profile" opens a dedicated form containing name fields, avatar uploading triggers, email/phone fields, and a free-form notes area.

## Classes Used

* **Client** ([Client](../classes/client.md)): Holds core data fields for customer records.
* **ClientLifecycle** ([ClientLifecycle](../classes/client_lifecycle.md)): Automatically calculates Active/New/Inactive labels.
* **Appointment** ([Appointment](../classes/appointment.md)): Gathered to derive lifecycle trends and populate visit history tab sheets.

## Commands

* `createClient(Client client)`: Inserts a new customer record into the local SQLite store.
* `updateClient(Client client)`: Updates an existing customer profile.
* `deleteClient(int id)`: Executes a soft delete on the record (`isDeleted = true`) to maintain local database-referential integrity and support future syncing.

## Queries

* `searchClients(String query, ClientStatus? statusFilter)` (`Stream<List<Client>>`): Retrieves reactive lists of matching client records based on search strings and toggled status bounds.
* `getClientDetails(int id)` (`Future<Client>`): Fetches a specific client profile by primary key.

## Validation

* Mandatory fields (`firstName`, `lastName`) are enforced with form field validation error banners.
* Input emails and phone formats are parsed via standard RegExp expressions.
* Duplicate username, phone, or email checks can trigger warning flags during creation.

## Edge Cases

* **Zero Client History**: If a fresh search matches nothing, the app presents a clean, themed empty state prompting registration ("This soul is not yet inscribed in the ledger...").
* **Visits Sync Discrepancy**: If the numerical `visits` value differs from the actual count of completed appointments in the local database, a system background job reconciles the integer to match physical appointment records.

## Future Ideas

* **Client Merging Engine**: Tool to safely merge duplicate records without breaking foreign keys (Appointments, Documents, Quotes).
* **Loyalty Perks**: Automated milestone rewards (e.g., automated gift vouchers sent when `visits` increments past 5).
