# Feature — Omens & Reports ("The Omens")

## Purpose

Aggregates and formats critical business stats (revenue over time, appointment distribution, active vs. inactive clients, individual artist metrics) into highly visual, thematic graphs and metric grids. This helps studio owners assess shop performance and financial trends locally.

## User Flow

1. **Access Hub**: The user navigates to "Omens & Reports" (Analytics).
2. **Select Scope**: The user toggles date range filters (e.g., Today, Week, Month, Year, or Custom range).
3. **Scan Graphs**: The interface populates line charts graphing weekly or monthly revenue totals and pie charts showing the distribution of service types (e.g., Tattooing vs. Piercing).
4. **Inspect Roster Metrics**: The user reviews a list of studio Artists, analyzing individual details like total logged hours, gross sales, and average commission yields.

## Classes Used

This analytic feature aggregates data from across multiple domains:

* **Appointment** ([Appointment](../classes/appointment.md)): Analyzed to aggregate pricing and duration indexes.
* **Client** ([Client](../classes/client.md)): Counted to outline registration rates.
* **User** ([User](../classes/user.md)): Queried to isolate artist performance and map default billing rates.

## Commands

* `recalculateReports()`: Forces SQLite query engines to re-run full database aggregates, refreshing analytical caches.

## Queries

* `getRevenueStats(DateTime start, DateTime end)` (`Stream<RevenueSummary>`): Aggregates total completed appointment values, separating net sales, gross revenue, and tax components within specified bounds.
* `getArtistPerformance(DateTime start, DateTime end)` (`Future<List<ArtistPerformanceReport>>`): Returns productivity summaries for all active Artists, displaying hours worked, totals billed, and calculated commission payouts.

## Validation

* Date scopes are checked to verify that the start boundary occurs before the end limit.
* Calculations must only process completed, non-deleted appointments (`status == "Completed"` and `isDeleted == false`).

## Edge Cases

* **Zero Work History**: If no bookings were marked completed during the selected timeframe, the app renders a clean empty state placeholder ("No omens are active for this cycle...") to prevent layout division-by-zero math crashes.

## Future Ideas

* **Export Ledger Sheets**: Compiling complete CSV spreadsheets of financial summaries to email directly to studio accountants.
* **Predictive Revenue Trends**: Harnessing basic statistical lines to forecast next month's gross revenue and scheduling density.
