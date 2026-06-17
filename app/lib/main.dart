/// Infernal Ink & Steel Suite - Main entry point
///
/// A tattoo shop management application ported from C#/ASP.NET Core to Flutter.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'app/app.dart';
import 'shared/util/shared_prefs_provider.dart';
import 'shared/util/app_version_helper.dart';
import 'shared/util/url_helper.dart';

const String appVersion = "1.0.3"; // bump every deploy

void main() async {
  handleHashRedirect();
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Supabase.initialize(
      url: 'https://nmrnbwnyivxktbjukspu.supabase.co',
      publishableKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5tcm5id255aXZ4a3RianVrc3B1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE0OTkyOTgsImV4cCI6MjA5NzA3NTI5OH0.v1rtUEOKUMs38TgXBEg03WQeWLE9DjDVyNgpLlLm2fU',
    );
  } catch (e) {
    debugPrint('Supabase initialization failed: $e');
  }

  // Version check (kills 90% of bugs)
  await checkAppVersion(appVersion);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const InfernalApp(),
    ),
  );
}
