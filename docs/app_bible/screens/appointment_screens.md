# Screen — Calendar & Booking Form Screens

## Purpose

Provides an interactive, visual schedule interface (Calendar view), direct access to waitlists (Purgatory), and detailed appointment input tools.

## Widgets

### 1. Calendar List Screen

* **Table Calendar Month Grid**: Interactive grid displaying monthly booking densities.
* **Toggle Buttons**: Toggles view modes (e.g., Month, Week, Day, List).
* **"Purgatory" Waitlist Slider Drawer**: Dynamic sliding drawer showing un-timed bookings.
* **Quick-Add Floating Button**: Floating button navigating directly to creation forms.

### 2. Appointment Form Screen

* **Client Selector dropdown**: Search and selection dropdown linking bookings to Clients.
* **Artist Selector dropdown**: dropdown selecting the conducting Artist.
* **Service Details field**: Styled text field to log service styles and notes.
* **Price & Duration fields**: Numerical field inputs compiling prices and booking durations.
* **Save/Commit Button**: Primary themed "Schedule Ritual" button.

## Inputs

* Form values: dropdown selectors, text field values.

## Outputs

* Persists appointment items in SQLite.

## Navigation

* `/appointments` → `/appointments/new` (creating a booking).
* `/appointments/:id` → `/appointments/:id/edit` (form editing).

## Uses Classes

* **Appointment** ([Appointment](../classes/appointment.md)): Ingested inside forms.
* **Client** ([Client](../classes/client.md)): Target recipient.
* **User** ([User](../classes/user.md)): The executing artist.

## States

* **Loading**: Calendar days show skeleton placeholders.
* **Active**: Highlights booked dates.
* **Empty State**: Displays detailed placeholder prompts if dates are empty ("The altar stands silent...").
* **Error State**: Flags schedule conflicts or invalid dates with red borders.
