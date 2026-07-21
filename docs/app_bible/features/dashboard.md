# Feature — Dashboard & "The Altar" Command Center

## Purpose

Provides a thematic, high-fidelity command center ("The Altar") summarizing the current operational state of the studio. This aggregates immediate, real-time analytics and lists today's booked sessions on a chronological timeline ("Blood Moon Timeline") with quick shortcuts to book new sessions or create clients.

## User Flow

1. **Landing**: Following authentication, the user lands on the Dashboard page.
2. **Reviewing Metrics**: The user scans four distinct "Holo-rune" metric cards displaying real-time metrics for today's sessions, active clients, document totals, and scheduled upcoming rituals.
3. **Timeline Inspection**: The user scrolls down to examine today's appointments listed sequentially with visual start/end hours and current statuses.
4. **Quick Action Triggering**: The user taps a quick shortcut button (e.g., "Inscribe Soul" to register a client, "Schedule Ritual" to book an appointment, or "Scribe Quote" to run an estimate), triggering router-level navigation.

## Classes Used

* **Appointment** ([Appointment](../classes/appointment.md)): Ingested to compile today's session timeline.
* **Client** ([Client](../classes/client.md)): Counts active profiles.
* **Document** ([Document](../classes/document.md)): Counts uploaded paperwork records.
* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Inspects visual preferences and announcement configurations.

## Commands

* `refreshDashboardStats()`: Invalidates local memory caches and forces a direct SQLite recount of active metrics.

## Queries

* `getDashboardStats()` (`DashboardStats`): Aggregates global totals from local tables, returning active client counts, document uploads, upcoming bookings, and today's session counts.
* `getTodaysTimeline()` (`List<Appointment>`): Retrieves non-deleted appointments scheduled for the current calendar date, ordered chronologically.

## Validation

* Aggregated counts must ignore any records marked as soft-deleted (`isDeleted == true`).
* The system date evaluate timeline bounds matching local timezone offsets.

## Edge Cases

* **No Bookings Today**: The calendar timeline renders a detailed, thematic empty state placeholder ("The altar stands silent today...").
* **Offline Stale Data**: The dashboard relies entirely on the local SQLite file. If database write events occur on separate threads, Drift triggers a reactive reload to refresh metrics in real-time.

## Future Ideas

* **Custom Widgets**: Drag-and-drop widget customization enabling artists to tailor metrics shown on their dashboards.
* **Real-time Local Alert Banners**: Floating banner panels warning artists about inventory depletions or immediate schedule conflicts.
