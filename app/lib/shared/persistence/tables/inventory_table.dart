import 'package:drift/drift.dart';

class InventoryItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 200)();
  TextColumn get category => text().withLength(min: 1, max: 100)();
  RealColumn get stockQuantity => real().withDefault(const Constant(0.0))();
  RealColumn get minimumQuantity => real().withDefault(const Constant(0.0))();
  TextColumn get unit => text().withLength(min: 1, max: 20)();
  TextColumn get supplier => text().nullable()();
  DateTimeColumn get lastOrderedAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
