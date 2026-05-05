// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communications_dao.dart';

// ignore_for_file: type=lint
mixin _$CommunicationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CommunicationsTableTable get communicationsTable =>
      attachedDatabase.communicationsTable;
  CommunicationsDaoManager get managers => CommunicationsDaoManager(this);
}

class CommunicationsDaoManager {
  final _$CommunicationsDaoMixin _db;
  CommunicationsDaoManager(this._db);
  $$CommunicationsTableTableTableManager get communicationsTable =>
      $$CommunicationsTableTableTableManager(
        _db.attachedDatabase,
        _db.communicationsTable,
      );
}
