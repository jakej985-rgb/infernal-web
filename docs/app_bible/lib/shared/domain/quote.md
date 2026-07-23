# Code Chronicle — quote.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/shared/domain/quote.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Quote entity matching legacy Domain/Quote.cs Represents a price estimate for a tattoo job. Primary key Optional foreign key to Client (quote may be for walk-in) Foreign key to User (Artist who created the quote) Body placement location Art style (Traditional, Realism, etc.) Whether this is a cover-up (adds complexity) Width dimension Height dimension Coverage level (1-5 scale) Line work complexity (1-5 scale) Shading complexity (1-5 scale) Color work complexity (1-5 scale) Overall difficulty (1-5 scale) Estimated hours - low end Estimated hours - high end Price estimate - low end Price estimate - high end Shop minimum rate applied Recommended deposit amount Confidence score (0-1, how reliable is this estimate) Number of similar past jobs used for estimation Free-form notes Path to reference photo Quote creation timestamp Private constructor for custom getters Calculated area (width × height) Average complexity across all factors Formatted price range string Formatted hours range string Create from JSON Input model for creating a quote estimate Matching legacy Domain/QuoteInput.cs Optional client ID Artist ID who is creating the quote Body placement location Art style Whether this is a cover-up Width dimension Height dimension Coverage level (1-5) Line complexity (1-5) Shading complexity (1-5) Color complexity (1-5) Overall difficulty (1-5) Free-form notes Reference photo path Create from JSON Output model for a calculated quote estimate Matching legacy Domain/QuoteEstimate.cs Estimated hours - low end Estimated hours - high end Price estimate - low end Price estimate - high end Shop minimum applied Recommended deposit Confidence score (0-1) Number of similar past jobs Create from JSON

---

## ⛓️ Import Dependencies
* `package:freezed_annotation/freezed_annotation.dart`

---

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
