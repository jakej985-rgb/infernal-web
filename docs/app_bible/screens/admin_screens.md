# Screen — User Management & System Status Screens

## Purpose

Enables Administrators to manage staff user accounts (ratios, display names, passwords) and audit system activities.

## Widgets

### 1. User Directory Screen

* **Roster Data Grid**: List of active and inactive staff, roles (Admin/Artist), and default rates.
* **Account Status Toggles**: In-row switches to deactivate artist accounts.

### 2. System Status & Audit Log Screen

* **System Status Ribbon**: Panel displaying DB version numbers and physical file locations.
* **Ledger Filter Ribbon**: Filters log items by date ranges or event severity levels (Info, Warning, Severe).
* **Audit Logs Table**: Scrollable table listing color-coded event descriptors.

## Inputs

* User field variables and logging filter bounds.

## Outputs

* Persists staff detail overrides in SQLite.

## Navigation

* `/admin` → `/admin/users/new` (creating accounts).
* `/admin` → `/admin/audit-logs` (opening logs).

## Uses Classes

* **User** ([User](../classes/user.md)): Core entity model.

## States

* **Active**: Renders data grids and tables.
* **Submitting**: Spinner states disabling input controls.
* **Empty State**: Bypassed. At least one admin is logged in.
* **Error State**: Outlines invalid rates or unique name conflicts.
