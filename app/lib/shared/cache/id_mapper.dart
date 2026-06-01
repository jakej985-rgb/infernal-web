import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/shared_prefs_provider.dart';

part 'id_mapper.g.dart';

@Riverpod(keepAlive: true)
IdMapper idMapper(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return IdMapper(prefs);
}

class IdMapper {
  final SharedPreferences _prefs;
  static const _storageKey = 'id_mapper_mappings';

  // Partitioned by entityType (e.g. 'client', 'appointment')
  final Map<String, Map<int, String>> _idToUuid = {};
  final Map<String, Map<String, int>> _uuidToId = {};

  IdMapper(this._prefs) {
    _loadMappings();
  }

  void _loadMappings() {
    try {
      final jsonStr = _prefs.getString(_storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final dynamic data = jsonDecode(jsonStr);
        if (data is Map<String, dynamic>) {
          // Detect if it is the legacy flat format or the new nested format
          final firstValue = data.values.isEmpty ? null : data.values.first;
          if (firstValue is Map) {
            // New nested format: { "client": { "uuid": id, ... } }
            data.forEach((entityType, mappings) {
              if (mappings is Map<String, dynamic>) {
                final typeUuidToId = _uuidToId.putIfAbsent(entityType, () => {});
                final typeIdToUuid = _idToUuid.putIfAbsent(entityType, () => {});
                mappings.forEach((uuid, idVal) {
                  final id = idVal as int;
                  typeIdToUuid[id] = uuid;
                  typeUuidToId[uuid] = id;
                });
              }
            });
            debugPrint('[IdMapper] Successfully loaded nested mappings.');
          } else {
            // Legacy flat format: { "12345": "uuid" } -> Migrate to "client"
            final typeUuidToId = _uuidToId.putIfAbsent('client', () => {});
            final typeIdToUuid = _idToUuid.putIfAbsent('client', () => {});
            data.forEach((key, value) {
              final id = int.tryParse(key);
              final uuid = value as String;
              if (id != null) {
                typeIdToUuid[id] = uuid;
                typeUuidToId[uuid] = id;
              }
            });
            debugPrint('[IdMapper] Migrated legacy flat mappings to "client" namespace.');
            // Save in the new format immediately to persist migration
            _saveMappings();
          }
        }
      }
    } catch (e) {
      debugPrint('[IdMapper] Error loading/migrating persistent mappings: $e');
      _idToUuid.clear();
      _uuidToId.clear();
      try {
        _prefs.remove(_storageKey);
      } catch (_) {}
    }
  }

  Future<void> _saveMappings() async {
    try {
      final Map<String, Map<String, int>> data = {};
      _uuidToId.forEach((entityType, mappings) {
        data[entityType] = mappings;
      });
      await _prefs.setString(_storageKey, jsonEncode(data));
    } catch (e) {
      debugPrint('[IdMapper] Error persisting mappings: $e');
    }
  }

  /// Registers a UUID and returns its stable, unique 31-bit positive integer ID.
  /// If the UUID already has an integer ID, that ID is returned.
  /// Otherwise, a new stable integer ID is generated, cached, and persisted.
  Future<int> registerUuid(String entityType, String uuid) async {
    final typeUuidToId = _uuidToId.putIfAbsent(entityType, () => {});
    final typeIdToUuid = _idToUuid.putIfAbsent(entityType, () => {});

    if (typeUuidToId.containsKey(uuid)) {
      return typeUuidToId[uuid]!;
    }

    var id = uuid.hashCode & 0x7FFFFFFF;
    if (id == 0) id = 1;

    var saltCount = 1;
    while (typeIdToUuid.containsKey(id) && typeIdToUuid[id] != uuid) {
      id = '${uuid}_$saltCount'.hashCode & 0x7FFFFFFF;
      if (id == 0) id = 1;
      saltCount++;
    }

    typeIdToUuid[id] = uuid;
    typeUuidToId[uuid] = id;

    await _saveMappings();
    return id;
  }

  /// Look up UUID by integer ID for a specific entity type
  String? getUuid(String entityType, int id) {
    return _idToUuid[entityType]?[id];
  }

  /// Look up integer ID by UUID for a specific entity type
  int? getId(String entityType, String uuid) {
    return _uuidToId[entityType]?[uuid];
  }
}
