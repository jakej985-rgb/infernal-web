# Screen — Dashboard Screen

## Purpose

Presents "The Altar" dashboard summarizing the daily operational timeline, key analytics, and quick-action triggers.

## Widgets

* **Special Message Banner**: Custom banner at the top showing global announcement texts.
* **"Holo-rune" Metric Grid**: Four interactive cards displaying:
  * "Today's Rituals" count.
  * "Bound Souls" (client total).
  * "Open Scrolls" (document total).
  * "Upcoming Rituals" count.
* **"Blood Moon" Chronological Timeline**: Scrollable timeline showing today's appointments with start/end indicators.
* **"Summoning Grid" Shortcuts**: Rapid action buttons floating on the dashboard to register clients, schedule sessions, or build quotes.

## Inputs

None directly. Listens to underlying reactive stats streams.

## Outputs

* Triggers navigation when tapping shortcuts.

## Navigation

* `/dashboard` → `/appointments` (calendar)
* `/dashboard` → `/clients/new` (registration form)
* `/dashboard` → `/quotes/new` (quote calculator)

## Uses Classes

* **Appointment** ([Appointment](../classes/appointment.md)): Compiles timeline items.
* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Accesses announcement text and visual color tokens.

## States

* **Loading**: Subtle loading skeletons painted inside metric cards.
* **Active**: Chronological list of daily appointments.
* **Empty State**: Displays an elegant placeholder when no sessions are booked ("The altar stands silent...").
* **Error State**: Retains standard metric layouts, replacing specific cards with detailed, red glow crash alerts.
