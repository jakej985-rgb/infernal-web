import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

/// Quote entity matching legacy Domain/Quote.cs
///
/// Represents a price estimate for a tattoo job.
@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    /// Primary key
    required int id,

    /// Optional foreign key to Client (quote may be for walk-in)
    int? clientId,

    /// Foreign key to User (Artist who created the quote)
    required int artistId,

    /// Body placement location
    @Default('') String placement,

    /// Art style (Traditional, Realism, etc.)
    @Default('') String style,

    /// Whether this is a cover-up (adds complexity)
    @Default(false) bool isCoverUp,

    /// Width dimension
    @Default(0.0) double width,

    /// Height dimension
    @Default(0.0) double height,

    /// Coverage level (1-5 scale)
    @Default(3) int coverageLevel,

    /// Line work complexity (1-5 scale)
    @Default(3) int lineComplexity,

    /// Shading complexity (1-5 scale)
    @Default(3) int shadingComplexity,

    /// Color work complexity (1-5 scale)
    @Default(3) int colorComplexity,

    /// Overall difficulty (1-5 scale)
    @Default(3) int difficulty,

    /// Estimated hours - low end
    @Default(0.0) double estimatedHoursLow,

    /// Estimated hours - high end
    @Default(0.0) double estimatedHoursHigh,

    /// Price estimate - low end
    @Default(0.0) double priceLow,

    /// Price estimate - high end
    @Default(0.0) double priceHigh,

    /// Shop minimum rate applied
    @Default(0.0) double shopMinimum,

    /// Recommended deposit amount
    @Default(0.0) double recommendedDeposit,

    /// Confidence score (0-1, how reliable is this estimate)
    @Default(0.0) double confidenceScore,

    /// Number of similar past jobs used for estimation
    @Default(0) int similarJobsCount,

    /// Free-form notes
    String? notes,

    /// Path to reference photo
    String? photoPath,

    /// Quote creation timestamp
    required DateTime createdAt,
  }) = _Quote;

  /// Private constructor for custom getters
  const Quote._();

  /// Calculated area (width × height)
  double get area => width * height;

  /// Average complexity across all factors
  double get averageComplexity =>
      (lineComplexity + shadingComplexity + colorComplexity + difficulty) / 4.0;

  /// Formatted price range string
  String get priceRangeFormatted =>
      '\$${priceLow.toStringAsFixed(0)} - \$${priceHigh.toStringAsFixed(0)}';

  /// Formatted hours range string
  String get hoursRangeFormatted =>
      '${estimatedHoursLow.toStringAsFixed(1)} - ${estimatedHoursHigh.toStringAsFixed(1)} hrs';

  /// Create from JSON
  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

/// Input model for creating a quote estimate
/// Matching legacy Domain/QuoteInput.cs
@freezed
abstract class QuoteInput with _$QuoteInput {
  const factory QuoteInput({
    /// Optional client ID
    int? clientId,

    /// Artist ID who is creating the quote
    required int artistId,

    /// Body placement location
    @Default('') String placement,

    /// Art style
    @Default('') String style,

    /// Whether this is a cover-up
    @Default(false) bool isCoverUp,

    /// Width dimension
    @Default(0.0) double width,

    /// Height dimension
    @Default(0.0) double height,

    /// Coverage level (1-5)
    @Default(3) int coverageLevel,

    /// Line complexity (1-5)
    @Default(3) int lineComplexity,

    /// Shading complexity (1-5)
    @Default(3) int shadingComplexity,

    /// Color complexity (1-5)
    @Default(3) int colorComplexity,

    /// Overall difficulty (1-5)
    @Default(3) int difficulty,

    /// Free-form notes
    String? notes,

    /// Reference photo path
    String? photoPath,
  }) = _QuoteInput;

  /// Create from JSON
  factory QuoteInput.fromJson(Map<String, dynamic> json) =>
      _$QuoteInputFromJson(json);
}

/// Output model for a calculated quote estimate
/// Matching legacy Domain/QuoteEstimate.cs
@freezed
abstract class QuoteEstimate with _$QuoteEstimate {
  const factory QuoteEstimate({
    /// Estimated hours - low end
    required double estimatedHoursLow,

    /// Estimated hours - high end
    required double estimatedHoursHigh,

    /// Price estimate - low end
    required double priceLow,

    /// Price estimate - high end
    required double priceHigh,

    /// Shop minimum applied
    required double shopMinimum,

    /// Recommended deposit
    required double recommendedDeposit,

    /// Confidence score (0-1)
    required double confidenceScore,

    /// Number of similar past jobs
    required int similarJobsCount,
  }) = _QuoteEstimate;

  /// Create from JSON
  factory QuoteEstimate.fromJson(Map<String, dynamic> json) =>
      _$QuoteEstimateFromJson(json);
}
