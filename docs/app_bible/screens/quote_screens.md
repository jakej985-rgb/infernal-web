# Screen — Quote Vault & Calculator Screens

## Purpose

Provides a responsive, multi-slider quote calculator (Calculator screen) and a historical archive list of generated estimates (Vault screen).

## Widgets

### 1. Quote Vault Screen

* **Vault Grid Table**: Color-coded table listing past estimates with body placements and date tags.
* **Estimate Card**: Renders price and hour bounds alongside matching confidence indicators.

### 2. Quote Calculator Screen

* **Anatomical Sizing Inputs**: Numeric inputs for width and height (in inches).
* **Multi-Slider Complexity Grid**: Five interactive slider bars ranging from 1 (simple) to 5 (complex) representing coverage, outline, shading, colors, and difficulty.
* **Cover-up Toggle**: Visual switch adding cover-up calculations.
* **Dynamic Time & Price Summary Card**: Glowing card summarizing real-time low/high bounds, recommended deposit amounts, and estimate confidence scores.

## Inputs

* Sizing text inputs and slider positions.

## Outputs

* Triggers calculation engine logic.
* Commits Quote records to SQLite.

## Navigation

* `/quotes` → `/quotes/new` (launching calculator).
* `/quotes/:id` → `/quotes` (exiting detail inspects).

## Uses Classes

* **Quote** ([Quote](../classes/quote.md)): Core estimate record.
* **QuoteInput** ([QuoteInput](../classes/quote.md)): Packs calculator inputs.
* **QuoteEstimate** ([QuoteEstimate](../classes/quote.md)): Packs generated projections.

## States

* **Calculating**: Live spinner overlays on calculation summaries.
* **Completed**: Renders calculated price ranges and deposit cards.
* **Empty State**: Renders clear prompts on empty vault lists ("The quote vault lies empty...").
* **Error State**: Outlines invalid measurements or missing artists with glowing error bars.
