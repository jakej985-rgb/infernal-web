# Code Chronicle — main.dart

## 📂 File Registry
* **Workspace Path**: `app/lib/main.dart`
* **Type**: Data Model / Utility

## 📖 Operational Purpose
Infernal Ink & Steel Suite - Main entry point A tattoo shop management application ported from C#/ASP.NET Core to Flutter.

---

## ⛓️ Import Dependencies
* `package:flutter/material.dart`
* `package:flutter_riverpod/flutter_riverpod.dart`
* `package:shared_preferences/shared_preferences.dart`
* `package:supabase_flutter/supabase_flutter.dart`
* `package:flutter_web_plugins/url_strategy.dart`
* `app/app.dart`
* `shared/util/shared_prefs_provider.dart`
* `shared/util/app_version_helper.dart`
* `shared/util/url_helper.dart`

---

## ⚙️ Methods & Routines (CQS Boundaries)
* **`main()`**: Handles data retrieval queries (Query).
* **`checkAppVersion()`**: Handles data retrieval queries (Query).
* **`InfernalApp()`**: Handles data retrieval queries (Query).

---

## 🛡️ Verification Tiers
* **Static Analysis**: Verified via `flutter analyze` linter constraints.
* **Coverage**: Audited against unit and widget test pipelines.
