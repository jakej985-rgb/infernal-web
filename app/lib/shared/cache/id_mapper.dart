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

  final Map<int, String> _idToUuid = {};
  final Map<String, int> _uuidToId = {};

  IdMapper(this._prefs) {
    _loadMappings();
  }

  void _loadMappings() {
    try {
      final jsonStr = _prefs.getString(_storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(jsonStr);
        data.forEach((key, value) {
          final id = int.tryParse(key);
          final uuid = value as String;
          if (id != null) {
            _idToUuid[id] = uuid;
            _uuidToId[uuid] = id;
          }
        });
        debugPrint('[IdMapper] Successfully loaded ${_idToUuid.length} mappings from persistent storage.');
      }
    } catch (e) {
      debugPrint('[IdMapper] Error loading persistent mappings (possible corruption fallback triggered): $e');
      _idToUuid.clear();
      _uuidToId.clear();
      try {
        _prefs.remove(_storageKey);
      } catch (_) {}
    }
  }

  Future<void> _saveMappings() async {
    try {
      final Map<String, String> data = {};
      _idToUuid.forEach((key, value) {
        data[key.toString()] = value;
      });
      await _prefs.setString(_storageKey, jsonEncode(data));
    } catch (e) {
      debugPrint('[IdMapper] Error persisting mappings: $e');
    }
  }

  /// Registers a UUID and returns its stable, unique 31-bit positive integer ID.
  /// If the UUID already has an integer ID, that ID is returned.
  /// Otherwise, a new stable integer ID is generated, cached, and persisted.
  Future<int> registerUuid(String uuid) async {
    if (_uuidToId.containsKey(uuid)) {
      return _uuidToId[uuid]!;
    }

    var id = uuid.hashCode & 0x7FFFFFFF;
    if (id == 0) id = 1;

    var saltCount = 1;
    while (_idToUuid.containsKey(id) && _idToUuid[id] != uuid) {
      id = '${uuid}_$saltCount'.hashCode & 0x7FFFFFFF;
      if (id == 0) id = 1;
      saltCount++;
    }

    _idToUuid[id] = uuid;
    _uuidToId[uuid] = id;

    await _saveMappings();
    return id;
  }

  /// Look up UUID by integer ID
  String? getUuid(int id) => _idToUuid[id];

  /// Look up integer ID by UUID
  int? getId(String uuid) => _uuidToId[uuid];
}
