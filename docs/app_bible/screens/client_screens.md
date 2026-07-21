# Screen — Client Directory & Form Screens

## Purpose

Enables staff to search the database of clients (Directory Screen), review client detail cards, uploaded files, and appointment histories (Details Screen), and register or edit profiles (Form Screen).

## Widgets

### 1. Client Directory Screen

* **Search Text Bar**: Text input bar filtering listings in real-time.
* **Lifecycle Toggle Row**: Buttons filtering active profiles by status (`bound`, `freshSoul`, `highValue`, `void_`).
* **Soul Grid / Card List**: Scrollable listing of client cards showing full names, status indicators, and contact values.

### 2. Client Details Screen

* **Profile Header**: Displays the client's avatar photograph, full name, email, phone, and total visit tally.
* **Derived Status Badge**: Color-coded indicator displaying the derived lifecycle rating ('New', 'Active', 'Inactive').
* **History Tabs Sheet**: Collapsible tab dividers routing users to:
  * **Rituals List**: Complete chronology of the client's upcoming and historical bookings.
  * **Document Vault**: Thumbnails and names of completed waivers or uploaded design stencils.
  * **Communications Ledger**: Chronology of transactional messages and SMS reminders.

### 3. Client Form Screen

* **Avatar Upload Trigger**: Tapping the avatar box launches image uploading dialogues.
* **Data Field Inputs**: Styled text fields for First, Middle, and Last names, Phone, Email, and free-form notes.
* **Action Button**: Primary themed "Inscribe Soul" execution button.

## Inputs

* Directory queries: `searchString`, `statusFilter`.
* Form targets: Form field controllers.

## Outputs

* Triggers updates to local SQLite client rows.
* Updates router nodes when tapping client cards.

## Navigation

* `/clients` → `/clients/:id` (browsing client profiles).
* `/clients/:id` → `/clients/:id/edit` (form editing mode).
* `/clients` → `/clients/new` (registration mode).

## Uses Classes

* **Client** ([Client](../classes/client.md)): Direct model painted inside forms.
* **ClientLifecycle** ([ClientLifecycle](../classes/client_lifecycle.md)): Determines detail status labels dynamically.
* **Appointment** ([Appointment](../classes/appointment.md)): populates the client's timeline.
* **Document** ([Document](../classes/document.md)): populates the attached files list.

## States

* **Loading**: Grid items display matching pulsing gray shimmer skeletons.
* **Active**: Directory lists clients. Details screens load tabs.
* **Empty State**: Displays clear prompts when searches yield no matching clients ("This soul is not yet inscribed in the ledger...").
* **Error State**: Renders detailed warning indicators over lists or inputs, highlighting empty mandatory fields with high-contrast red warning banners.
