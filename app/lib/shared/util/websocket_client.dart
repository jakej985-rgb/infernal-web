import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'shared_prefs_provider.dart';

part 'websocket_client.g.dart';

@Riverpod(keepAlive: true)
class WebSocketClient extends _$WebSocketClient {
  html.WebSocket? _socket;
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

  void _connect(StreamController<Map<String, dynamic>> controller) {
    if (_isDisposed) return;

    final prefs = ref.read(sharedPreferencesProvider);
    final baseUrl = prefs.getString('api_base_url') ?? 'api.inkandsteel.xyz';
    final token = prefs.getString('auth_jwt_token') ?? '';

    // Determine scheme based on base URL
    final isSecure =
        baseUrl.contains('https') || baseUrl.startsWith('infernal-api');
    final wsScheme = isSecure ? 'wss' : 'ws';

    // Clean host formatting
    var host = baseUrl
        .replaceAll('http://', '')
        .replaceAll('https://', '')
        .trim();

    if (host.isEmpty) {
      host = 'localhost:8080';
    }

    final uri = '$wsScheme://$host/ws?token=$token';

    try {
      debugPrint('[WebSocket] Connecting to $uri...');
      _socket = html.WebSocket(uri);

      _socket!.onOpen.listen((_) {
        debugPrint('[WebSocket] Connected successfully.');
      });

      _socket!.onMessage.listen((event) {
        try {
          final data = event.data;
          if (data is String) {
            final parsed = jsonDecode(data) as Map<String, dynamic>;
            controller.add(parsed);
            debugPrint('[WebSocket] Message received: $parsed');
          }
        } catch (e) {
          debugPrint('[WebSocket] Error parsing incoming message: $e');
        }
      });

      _socket!.onError.listen((err) {
        debugPrint('[WebSocket] Connection error: $err');
        _reconnect(controller);
      });

      _socket!.onClose.listen((_) {
        debugPrint('[WebSocket] Connection closed by remote host.');
        _reconnect(controller);
      });
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
