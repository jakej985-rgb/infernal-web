import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'sync_manager.dart';

part 'sync_worker.g.dart';

@Riverpod(keepAlive: true)
class SyncWorker extends _$SyncWorker {
  Timer? _timer;
  bool _isSyncing = false;

  @override
  void build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    // Start background sync interval (every 30 seconds)
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      triggerSync();
    });
  }

  Future<void> triggerSync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final manager = ref.read(syncManagerProvider);
      await manager.sync();
    } catch (e) {
      debugPrint('[SyncWorker] Background sync execution failed: $e');
    } finally {
      _isSyncing = false;
    }
  }
}
