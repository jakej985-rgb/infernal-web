/// Infernal Ink & Steel Suite - Main entry point
///
/// A tattoo shop management application ported from C#/ASP.NET Core to Flutter.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'firebase_options.dart';
import 'shared/util/shared_prefs_provider.dart';
import 'shared/util/app_version_helper.dart';

const String APP_VERSION = "1.0.2"; // bump every deploy

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  // Version check (kills 90% of bugs)
  await checkAppVersion(APP_VERSION);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const InfernalApp(),
    ),
  );
}
