import 'package:drift/drift.dart';

class CommunicationsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncId => text().withDefault(const Constant(''))();
  IntColumn get clientId => integer().nullable()();
  TextColumn get clientName => text()();
  TextColumn get type => text()(); // SMS, EMAIL, RITUAL
  TextColumn get direction => text()(); // INBOUND, OUTBOUND
  TextColumn get content => text()();
  DateTimeColumn get sentAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get status => text().withDefault(const Constant('SENT'))();
  DateTimeColumn get lastModifiedUtc => dateTime().withDefault(currentDateAndTime)();
  TextColumn get lastModifiedBy => text().withDefault(const Constant(''))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
}
