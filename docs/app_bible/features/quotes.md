# Feature — Smart Quote Calculator

## Purpose

Standardizes and generates analytical time and cost estimates for custom tattoo requests. By analyzing visual dimensions, ink densities, cover-up conditions, and multiple detail complexity factors, it ensures consistent, fair, and highly accurate shop pricing.

## User Flow

1. **Starting a Quote**: The user navigates to `/quotes/new` or launches the wizard from a client profile screen.
2. **Entering Physical Attributes**: The operator defines physical parameters:
   * **Placement**: Where on the body (e.g., Forearm, Thigh, Ribs).
   * **Style**: Artistic genre (e.g., Traditional, Realism, Geometric).
   * **Dimensions**: Width and Height measurements in inches.
   * **Cover-up**: Toggle checkbox if covering a pre-existing design.
3. **Rating Complexity**: The user adjusts five sliding scale nodes (1 to 5 stars) mapping: Coverage Level, Line Work, Shading Depth, Color Blending, and Overall Difficulty.
4. **Generating the Oracle (Calculation)**: The user clicks "Calculate Quote". The estimation algorithm executes instantly, printing:
   * **Hours Range**: Estimated duration range (low to high).
   * **Price Range**: Estimated billing cost boundaries.
   * **Earnest Deposit**: Recommended deposit required during bookings.
   * **Confidence Score**: Statistical rating of estimate reliability based on database historical density records.
5. **Filing the Quote**: The user clicks "Inscribe Quote" to save the estimate to `/quotes`, binding it to a client file or leaving it unlinked for walking prospects.

---

## Classes Used

* [Quote](../classes/quote.md) (The master persistent record)
* [QuoteInput](../classes/quote.md) (Unified input model)
* [QuoteEstimate](../classes/quote.md) (Calculated estimation outputs)
* [ShopSettings](../classes/shop_settings.md) (References standard hourly rates and shop minimum charges)

---

## Commands

* `createQuote(QuoteInput input)`: Triggers calculations via the logic service, merges results into a completed `Quote` schema, and saves the estimate to SQLite local storage.
* `deleteQuote(int quoteId)`: Purges the selected estimate from local database indexes.

---

## Queries

* `QuoteEstimate calculateEstimate(QuoteInput input, ShopSettings settings, double artistSpeed)`: Executes the mathematical calculation algorithm:
  $$baseHours = 0.5 + (width \times height \times 0.05 \times \frac{coverageLevel}{3.0})$$
  $$avgComplexity = \frac{lineComplexity + shadingComplexity + colorComplexity + difficulty}{4.0}$$
  $$complexityMultiplier = 0.8 + (avgComplexity \times 0.4)$$
  $$estimatedHours = baseHours \times complexityMultiplier \times (isCoverUp ? 1.5 : 1.0)$$
  * Sets low hours to $0.8 \times estimatedHours$ and high hours to $1.2 \times estimatedHours$.
  * Prices are calculated as $hours \times settings.tattooPerHour$ (enforcing `settings.shopMinimumRate` where necessary).
  * Deposit is calculated at $20\%$ of the low price estimate (or custom configurations from `ShopSettings`).
* `List<Quote> getAllQuotes({int? clientId, int? artistId})`: Retrieves list of saved estimates from SQLite.

---

## Validation

* **Positive Boundaries**: Dimensions must strictly be greater than zero.
* **Rating Limits**: Complexity levels must fall in the integer range of 1 to 5 inclusive.

---

## Edge Cases

* **Sub-Minimum Estimates**: If the calculated low-end price estimate falls below the configured shop minimum (e.g., a tiny dot tattoo calculating to $35), the algorithm automatically overrides the boundaries to output the standard `shopMinimumRate` (e.g., $100).

---

## Future Ideas

* **In-App Stencil Area Scan**: Utilizing a device's camera to scan stencils, automatically measuring area pixels to populate width/height dimensions.
* **Conversion Trigger**: A simple CTA button directly transforming a completed quote file into an active calendar appointment booking.
