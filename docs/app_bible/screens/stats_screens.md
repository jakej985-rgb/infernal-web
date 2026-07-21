# Screen — Statistics Overview Screen

## Purpose

Enables users (principally Admins) to monitor and review studio health, revenue metrics, service ratios, and artist workloads.

## Widgets

* **Rune Metrics Ribbon**: Panel highlighting gross sales, average hourly yields, and client retention rates.
* **Line Chart Widget**: Displays revenue curves over configurable date windows.
* **Service Share Pie Chart**: Pie graphic dividing totals of tattooing versus piercing.
* **Artist Leaderboard Grid**: Scrollable data grid listing total artist hours worked, revenue completed, and commission slices.

## Inputs

* Date bounds and filter scopes.

## Outputs

None directly. Pure read-only analytics views.

## Navigation

* `/stats` → `/dashboard` (return navigation).

## Uses Classes

* **Appointment** ([Appointment](../classes/appointment.md)): Ingested to compile aggregate figures.
* **User** ([User](../classes/user.md)): Separates statistics by artist.

## States

* **Loading**: Charts draw shimmer gradients.
* **Active**: Draws data charts and leaderboards.
* **Empty State**: Renders empty state placeholders if zero sessions match date filters ("No active omens for this cycle...").
* **Error State**: Safe layout fallbacks mapping textual numbers to prevent app-level divisions by zero.
