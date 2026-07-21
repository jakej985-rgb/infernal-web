# Feature — Rituals Scheduler & Purgatory ("The Calendars")

## Purpose

Enables administrators and artists to manage, schedule, and block time slots on the studio calendar, tracking individual artist rosters. This supports scheduling active sessions, handling block-offs (personal time, shop meetings), and managing the waitlist ("Purgatory").

## User Flow

1. **Calendar Browsing**: The user accesses the Appointments ledger, choosing between standard list tables or an interactive, colored monthly calendar widget.
2. **Scheduling a Session**: Tapping an open calendar slot opens the scheduling form. The user selects a registered Client, specifies the executing Artist, sets start/end dates, inputs pricing categories, and uploads reference sketches.
3. **Waitlist Routing**: If a booking has no confirmed time slots, the user schedules it with a special "Waitlist" status. This routes the slot to the "Purgatory" sliding side drawer.
4. **Rescheduling & Status Updates**: Users can drag and drop calendar cards to modify start times, or open details cards to log transitions (e.g., mark "InProgress", "Completed", or "NoShow").

## Classes Used

* **Appointment** ([Appointment](../classes/appointment.md)): Core temporal data class.
* **Client** ([Client](../classes/client.md)): Linked client receiver.
* **User** ([User](../classes/user.md)): The executing artist.
* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Ingests calendar buffers and operating hour limits.

## Commands

* `createAppointment(Appointment appt)`: Persists a scheduling entry or time-block.
* `updateAppointmentStatus(int id, String status)`: Modifies the operational state of a booking (Scheduled, Completed, Cancelled, etc.).
* `deleteAppointment(int id)`: Executes a soft delete on a calendar card.

## Queries

* `getAppointmentsStream(DateTime start, DateTime end)` (`Stream<List<Appointment>>`): Returns reactive, live database listings of appointments spanning specified calendar ranges.
* `getPurgatoryWaitlist()` (`Future<List<Appointment>>`): Retrieves non-deleted waitlisted bookings.

## Validation

* Appointments cannot be created outside global shop hours unless explicit overrides are authorized by an Admin.
* The start time must fall strictly before the calculated end time.
* Warnings are raised if a new booking conflicts with an existing appointment for the same Artist, or falls within their `bookingBufferMinutes` buffer boundary.

## Edge Cases

* **Double Bookings**: While warning alerts block duplicate bookings for the same artist in the standard UI, manual Admin overrides can bypass conflicts to support concurrent session blocks (e.g., apprentice supervision).
* **Missing Client Name on Blocks**: When `isBlockOff` is toggled `true`, form validations for mandatory `clientId` references are bypassed to support personal time blocks.

## Future Ideas

* **Client Portal Sync**: Expose open calendar openings to a web portal so clients can request slots directly.
* **Automated Cancellation Refilling**: Automatically notify waitlisted ("Purgatory") clients via SMS when an appointment slot cancels.
