# Presentation — DashboardPage

## Purpose

Provides a responsive hub of high-value metrics, visual timelines, and quick action pathways to execute core workflows instantaneously.

## Widgets / Visual Style

* **SliverAppBar with Floating Drawer Menu**: Displays a centered, glowing title header. On mobile and smaller viewports (< 800px width), it displays a leading three-bar hamburger menu button that slides open the parent `AppShell` drawer navigation.
* **Glowing Metrics Grid (Summoning Metrics)**: Displays key metrics including:
  * Today's Rituals (Blood Red glow)
  * Bound Souls / Active Clients (Arcane Cyan glow)
  * Open Scrolls / Quotes (Gold glow)
  * Pending Actions / Waitlist (Void Gray glow)
* **Timeline list**: Translucent glass-morphic list tiles presenting today's appointments.
* **Quick Actions Portal**: Rounded action button cards dynamically resizing in columns according to screen width.

## Navigation

* Launches deep-linked paths for all pages (Calendar, Clients, Quotes, settings, etc.) dynamically.
