# Screen — Tools Hub Screens (Pain Estimator / Flash Roulette)

## Purpose

Provides interactive utilities ("The Arsenal") to consult with clients and randomize design ideas.

## Widgets

### 1. The Arsenal Hub Screen

* **Grid Navigation Panel**: Visual tiles routing to the individual utilities.

### 2. Pain Estimator Screen

* **Anatomical Body Vector Map**: Responsive silhouette canvas mapping body part click boundaries.
* **Pain Scale Slide Panel**: slide card describing pain categories with advisory descriptions and average time-frames.

### 3. Flash Roulette Screen

* **Animated Roulette Wheel Canvas**: Circular canvas spinning with custom ease curves and ticks.
* **Spin Button**: Primary gothic-themed trigger.
* **Result Banner**: Reveals the landed design option with glow overlays.

## Inputs

* Silhouette coordinate taps and "Spin" button presses.

## Outputs

* Dispatches animations.

## Navigation

* `/tools` → `/tools/pain-estimator` (launching Estimator).
* `/tools` → `/tools/flash-roulette` (launching Roulette).

## Uses Classes

* **ShopSettings** ([ShopSettings](../classes/shop_settings.md)): Accesses asset routes and standard rate thresholds.

## States

* **Active**: Standby. Ready for inputs.
* **Spinning**: Toggles wheel ticker timers.
* **Empty State**: Bypassed.
* **Error State**: Falls back to textual list arrays if silhouettes or canvases fail to render.
