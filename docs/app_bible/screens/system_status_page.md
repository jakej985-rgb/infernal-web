# Presentation — SystemStatusPage

## Purpose

Provides Super Users with active, real-time monitoring of local platform operations and Supabase database connectivity.

## Widgets / Visual Style

* **Live Sanctuary Monitoring (Neon Card)**: An elegant `NeonPlate` card that dynamically "lights up" according to the database status (Emerald Green for connected, Fiery Red for offline/errors).
* **Live Connection Indicators**: Displays a pulsing status light next to a dynamic connection tag ("Connected" or "Offline / Failed").
* **Supabase Endpoint**: Dynamically presents the active Supabase project endpoint URL (`https://nmrnbwnyivxktbjukspu.supabase.co`).
* **Interactive Re-Verify Action**: A hard-edged refresh button ("RE-VERIFY CONNECTION") executing live asynchronous queries against the remote database on-demand to audit connections.

## Uses Classes

* **UserRole** ([UserRole](../classes/enums.md)): Restricted strictly to `su` (Super User) access.
