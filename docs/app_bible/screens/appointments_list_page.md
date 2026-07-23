# Presentation — AppointmentsListPage

## Purpose

Serves as the schedules interface, displaying monthly booking densities and a list of upcoming appointment slots.

## Widgets / Visual Style

* **Neon Calendar Grid Frame**: The calendar grid is enclosed inside a gorgeous glowing red `NeonPlate` frame.
* **Arcane Today Marker**: Shows the current day highlighted with a glowing, circular arcane-blue ring.
* **Glowing Selected Day Orbit**: Displays the currently selected date inside a filled blood-red circular orbit with deep neon glow shadows.
* **Active Status Dots (Visions Indicator)**: Displays glowing micro-dots below each date cell matching event statuses (green for completed, red for scheduled, crimson for cancelled).
* **Corner Count Badges**: Every date cell with scheduled appointments dynamically lights up with a subtle red-tinted background and displays a glowing circular count badge in its top-right corner.
* **Toggle View Actions**: Toggles between interactive calendar and list-only configurations.

## Uses Classes

* **Appointment** ([Appointment](../classes/appointment.md)): Core event models.
