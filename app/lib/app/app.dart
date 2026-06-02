/// Main application widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/theme.dart';
import '../shared/util/websocket_client.dart';

/// Root application widget
class InfernalApp extends ConsumerWidget {
  const InfernalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Initialize real-time WebSockets
    ref.watch(webSocketClientProvider);

    return MaterialApp.router(
      title: 'Infernal Ink & Steel',
      debugShowCheckedModeBanner: false,
      theme: createInfernalTheme(),
      routerConfig: router,
    );
  }
}
