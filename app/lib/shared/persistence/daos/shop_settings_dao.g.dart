// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_settings_dao.dart';

// ignore_for_file: type=lint
mixin _$ShopSettingsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ShopSettingsTableTable get shopSettingsTable =>
      attachedDatabase.shopSettingsTable;
  ShopSettingsDaoManager get managers => ShopSettingsDaoManager(this);
}

class ShopSettingsDaoManager {
  final _$ShopSettingsDaoMixin _db;
  ShopSettingsDaoManager(this._db);
  $$ShopSettingsTableTableTableManager get shopSettingsTable =>
      $$ShopSettingsTableTableTableManager(
        _db.attachedDatabase,
        _db.shopSettingsTable,
      );
}
