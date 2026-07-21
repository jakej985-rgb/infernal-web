# Quote

## Purpose

Represents an algorithmic price and duration estimate for a tattoo design based on dimensions, style, body placement, and multi-factor graphic complexity. This supports both booked clients and walk-in prospects.

## Responsibilities

* Persists details of tattoo inquiries and calculated hour/price ranges.
* Encapsulates art style, dimensions (width/height), and body placement.
* Records five dimensions of complexity (coverage, line work, shading, color, difficulty).
* Standardizes pricing and deposit values across the shop.

## Properties

### 1. Quote Record (`Quote`)

* `id` (`int`): Primary domain identifier.
* `clientId` (`int?`): Optional foreign key to [Client](./client.md) (can be null for anonymous walk-in inquiries).
* `artistId` (`int`): Foreign key identifying the estimating [User](./user.md) (Artist).
* `placement` (`String`): Intended body location (e.g., 'Forearm', 'Ribs').
* `style` (`String`): Artistic design style (e.g., 'Traditional', 'Realism', 'Blackwork').
* `isCoverUp` (`bool`): Toggle indicating if the tattoo covers up a pre-existing design (adds 50% complexity).
* `width` (`double`): Horizontal dimension of the design in inches.
* `height` (`double`): Vertical dimension of the design in inches.
* `coverageLevel` (`int`): Ink density score (1-5 scale).
* `lineComplexity` (`int`): Outline complexity score (1-5 scale).
* `shadingComplexity` (`int`): Shading depth and volume score (1-5 scale).
* `colorComplexity` (`int`): Color blending and layering complexity score (1-5 scale).
* `difficulty` (`int`): Overall physical execution difficulty score (1-5 scale).
* `estimatedHoursLow` (`double`): Low-end hour estimate for session completion.
* `estimatedHoursHigh` (`double`): High-end hour estimate for session completion.
* `priceLow` (`double`): Low-end price calculation for client billing.
* `priceHigh` (`double`): High-end price calculation for client billing.
* `shopMinimum` (`double`): Minimum shop charge rate applied to the quote.
* `recommendedDeposit` (`double`): Required earnest money deposit (defaults to 20% of low price estimate).
* `confidenceScore` (`double`): Statistical accuracy indicator of the estimate (0.0 to 1.0).
* `similarJobsCount` (`int`): Number of historical matching jobs utilized to compile the score.
* `notes` (`String?`): Additional design specifications or client-supplied details.
* `photoPath` (`String?`): Local storage path referencing sketch designs or stencils.
* `createdAt` (`DateTime`): Timestamp tracking when the estimate was logged.

### 2. Quote Creation Input (`QuoteInput`)

* Encapsulates data required to run an estimate calculation, mirroring complexity and physical parameters without requiring generated estimate properties.

### 3. Generated Estimate Output (`QuoteEstimate`)

* Read-only structure housing calculated outputs (`estimatedHoursLow`, `estimatedHoursHigh`, `priceLow`, `priceHigh`, `shopMinimum`, `recommendedDeposit`, `confidenceScore`, `similarJobsCount`) returned by the Quote calculation service.

---

## Methods

### Commands

* `Quote.fromJson(Map<String, dynamic> json)`: Reconstructs a Quote from serialized JSON.
* `QuoteInput.fromJson(Map<String, dynamic> json)`: Reconstructs a QuoteInput model from JSON.
* `QuoteEstimate.fromJson(Map<String, dynamic> json)`: Reconstructs a QuoteEstimate calculation output from JSON.

### Queries

* `double get area`: Computes overall design area (`width * height`).
* `double get averageComplexity`: Dynamic evaluation averaging `lineComplexity`, `shadingComplexity`, `colorComplexity`, and `difficulty` (1.0 to 5.0).
* `String get priceRangeFormatted`: Renders the high/low price boundaries (e.g., "$150 - $220").
* `String get hoursRangeFormatted`: Renders the high/low hour boundaries (e.g., "1.0 - 1.5 hrs").
* `toJson()` (`Map<String, dynamic>`): Serializes instances.

---

## Validation Rules

* **Dimensions**: Both `width` and `height` must be greater than zero.
* **Complexity Nodes**: Each individual score (coverage, line, shading, color, difficulty) must be an integer between 1 and 5 inclusive.
* **Hours**: High hour range must be greater than or equal to low hour range.

---

## Relationships

### Owns

None directly, except associated file assets in `photoPath`.

### Owned By

* **Artist** ([User](./user.md)): The estimator who compiles the pricing.
* **Client** ([Client](./client.md)): The optional target customer for the estimate.

### Uses

* **Complexity Scales** (1-5 integer boundaries).

### Used By

* [Quotes Calculator Feature](../features/quotes.md) (Business algorithm core)
* [Quotes Detail and Form Screens](../screens/quote_screens.md) (Renders calculator inputs and outputs)

---

## Future Expansion

* **Client Conversion Flow**: Direct execution flow command to promote a completed `Quote` to an active `Appointment` booking, retaining reference images and notes.
* **Machine Learning Refinements**: Retraining statistical accuracy parameters on active artist speeds dynamically.

---

## Open Questions

* Should the quote calculator algorithm dynamically adjust low and high hour ranges based on the specific creating Artist's individual `speedFactor` property? (Currently planned as a future system enhancement).
