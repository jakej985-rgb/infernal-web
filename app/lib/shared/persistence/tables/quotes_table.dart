import 'package:drift/drift.dart';

/// Quotes table for storing price estimates
/// Maps to: legacy Domain/Quote.cs
class Quotes extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Optional foreign key to Client
  IntColumn get clientId => integer().nullable()();

  /// Foreign key to User (Artist who created the quote)
  IntColumn get artistId => integer()();

  /// Body placement location
  TextColumn get placement => text().withDefault(const Constant(''))();

  /// Art style (Traditional, Realism, etc.)
  TextColumn get style => text().withDefault(const Constant(''))();

  /// Whether this is a cover-up
  BoolColumn get isCoverUp => boolean().withDefault(const Constant(false))();

  /// Width dimension
  RealColumn get width => real().withDefault(const Constant(0.0))();

  /// Height dimension
  RealColumn get height => real().withDefault(const Constant(0.0))();

  /// Coverage level (1-5 scale)
  IntColumn get coverageLevel => integer().withDefault(const Constant(3))();

  /// Line work complexity (1-5 scale)
  IntColumn get lineComplexity => integer().withDefault(const Constant(3))();

  /// Shading complexity (1-5 scale)
  IntColumn get shadingComplexity => integer().withDefault(const Constant(3))();

  /// Color work complexity (1-5 scale)
  IntColumn get colorComplexity => integer().withDefault(const Constant(3))();

  /// Overall difficulty (1-5 scale)
  IntColumn get difficulty => integer().withDefault(const Constant(3))();

  /// Estimated hours - low end
  RealColumn get estimatedHoursLow => real().withDefault(const Constant(0.0))();

  /// Estimated hours - high end
  RealColumn get estimatedHoursHigh =>
      real().withDefault(const Constant(0.0))();

  /// Price estimate - low end
  RealColumn get priceLow => real().withDefault(const Constant(0.0))();

  /// Price estimate - high end
  RealColumn get priceHigh => real().withDefault(const Constant(0.0))();

  /// Shop minimum rate applied
  RealColumn get shopMinimum => real().withDefault(const Constant(0.0))();

  /// Recommended deposit amount
  RealColumn get recommendedDeposit =>
      real().withDefault(const Constant(0.0))();

  /// Confidence score (0-1)
  RealColumn get confidenceScore => real().withDefault(const Constant(0.0))();

  /// Number of similar past jobs
  IntColumn get similarJobsCount => integer().withDefault(const Constant(0))();

  /// Free-form notes
  TextColumn get notes => text().nullable()();

  /// Path to reference photo
  TextColumn get photoPath => text().nullable()();

  /// Quote creation timestamp
  DateTimeColumn get createdAt => dateTime()();
}
