/// Main application widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/theme.dart';
import '../features/auth/domain/auth_service.dart';

class InfernalApp extends ConsumerWidget {
  const InfernalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateAsync = ref.watch(authServiceProvider);

    if (authStateAsync.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: createInfernalTheme(),
        home: const Scaffold(
          backgroundColor: InfernalColors.background,
          body: Center(
            child: CircularProgressIndicator(color: InfernalColors.blood),
          ),
        ),
      );
    }

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Infernal Ink & Steel',
      debugShowCheckedModeBanner: false,
      theme: createInfernalTheme(),
      routerConfig: router,
    );
  }
}
