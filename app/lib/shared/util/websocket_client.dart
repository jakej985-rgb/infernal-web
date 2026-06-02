import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_prefs_provider.dart';

part 'websocket_client.g.dart';

@Riverpod(keepAlive: true)
class WebSocketClient extends _$WebSocketClient {
  WebSocket? _socket;
  Timer? _reconnectTimer;
  bool _isDisposed = false;

  @override
  Stream<Map<String, dynamic>> build() {
    ref.onDispose(() {
      _isDisposed = true;
      _reconnectTimer?.cancel();
      _socket?.close();
    });

    final controller = StreamController<Map<String, dynamic>>();
    _connect(controller);
    return controller.stream;
  }

  void _connect(StreamController<Map<String, dynamic>> controller) async {
    if (_isDisposed) return;
    if (kIsWeb) {
      debugPrint('[WebSocket] WebSocket connections via dart:io are disabled on the Web.');
      return;
    }

    final prefs = ref.read(sharedPreferencesProvider);
    final baseUrl = prefs.getString('api_base_url') ?? 'api.inkandsteel.xyz';
    final token = prefs.getString('auth_jwt_token') ?? '';

    // Determine scheme based on base URL
    final isSecure = baseUrl.contains('https') || baseUrl.startsWith('infernal-api');
    final wsScheme = isSecure ? 'wss' : 'ws';
    
    // Clean host formatting
    var host = baseUrl
        .replaceAll('http://', '')
        .replaceAll('https://', '')
        .trim();

    if (host.isEmpty) {
      host = 'localhost:8080';
    }

    final uri = Uri.parse('$wsScheme://$host/ws?token=$token');

    try {
      debugPrint('[WebSocket] Connecting to $uri...');
      _socket = await WebSocket.connect(uri.toString()).timeout(const Duration(seconds: 5));
      debugPrint('[WebSocket] Connected successfully.');

      _socket!.listen(
        (data) {
          try {
            if (data is String) {
              final parsed = jsonDecode(data) as Map<String, dynamic>;
              controller.add(parsed);
              debugPrint('[WebSocket] Message received: $parsed');
            }
          } catch (e) {
            debugPrint('[WebSocket] Error parsing incoming message: $e');
          }
        },
        onError: (err) {
          debugPrint('[WebSocket] Connection error: $err');
          _reconnect(controller);
        },
        onDone: () {
          debugPrint('[WebSocket] Connection closed by remote host.');
          _reconnect(controller);
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('[WebSocket] Connection attempt failed: $e');
      _reconnect(controller);
    }
  }

  void _reconnect(StreamController<Map<String, dynamic>> controller) {
    if (_isDisposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      _connect(controller);
    });
  }
}
