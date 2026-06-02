/// Infernal Ink & Steel Suite - Main entry point
///
/// A tattoo shop management application ported from C#/ASP.NET Core to Flutter.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app/app.dart';
import 'firebase_options.dart';
import 'shared/util/shared_prefs_provider.dart';
import 'shared/util/app_version_helper.dart';

const String APP_VERSION = "1.0.0"; // bump every deploy

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

  // Auth Gate & Token Refresh
  final user = FirebaseAuth.instance.currentUser;
  print("USER: ${user?.uid}");
  print("VERSION: $APP_VERSION");
  print("ROUTE: deciding...");

  if (user != null) {
    try {
      // Force token refresh on load
      await user.getIdToken(true);

      // Verify Firestore user document exists and is not deleted
      final userDoc = await FirebaseFirestore.instance
          .collection('organizations')
          .doc('default-org')
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || (userDoc.data()?['isDeleted'] == true)) {
        debugPrint("Auth Gate: User document does not exist or is deleted in Firestore. Signing out.");
        await FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      debugPrint("Auth Gate/token refresh failed, signing out: $e");
      try {
        await FirebaseAuth.instance.signOut();
      } catch (_) {}
    }
  }

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const InfernalApp(),
    ),
  );
}
