# Dependency Update Report

**Date:** 2026-01-21  
**Agent:** DepGuardian 🛡️

---

## Environment

- **Flutter:** 3.38.5 (stable)
- **Dart:** 3.10.4 (stable)
- **OS:** Windows x64

---

## Summary

### ✅ Current State: All Green

| Check               | Status               |
|---------------------|----------------------|
| `flutter analyze`   | ✅ No issues found    |
| `flutter test`      | ✅ 42/42 passed        |

### ✅ Previously Applied Upgrades

| Package               | From    | To         |
|-----------------------|---------|------------|
| `google_fonts`        | 6.2.1   | 7.1.0      |
| `go_router`           | 15.1.2  | 17.0.0     |
| `flutter_riverpod`    | 2.6.1   | 3.1.0      |
| `riverpod_annotation` | 2.6.1   | 4.0.0      |
| `riverpod_generator`  | 2.6.5   | 4.0.0+1    |
| `drift`               | 2.28.0  | 2.30.0     |
| `drift_dev`           | 2.28.0  | 2.30.0     |

### ❌ Blocked Upgrades (Dependency Conflicts)

| Package               | Current | Latest | Reason |
|-----------------------|---------|--------|--------|
| `flutter_riverpod`    | 3.1.0   | 3.2.0  | Conflicts with `drift_dev` via `test_api` version mismatch |
| `riverpod_annotation` | 4.0.0   | 4.0.1  | Same `test_api` conflict |
| `riverpod_generator`  | 4.0.0+1 | 4.0.2  | Same `test_api` conflict |
| `freezed`             | 3.2.3   | 3.2.4  | Requires `test_api` 0.7.9, conflicts with Flutter SDK |
| `json_serializable`   | 6.11.2  | 6.11.4 | Same `test_api` conflict |

**Root Cause:** The latest versions of `riverpod`, `freezed`, and `json_serializable` require `test_api` 0.7.8-0.7.9, but `flutter_test` from the SDK pins `test_api` to 0.7.7. This is a transitive dependency conflict that cannot be resolved without a Flutter SDK upgrade.

---

## Baseline Snapshot

### `flutter pub outdated` Output

```
Package Name              Current       Upgradable    Resolvable    Latest       

direct dependencies:     
flutter_riverpod          *3.1.0        *3.1.0        *3.1.0        3.2.0        
riverpod_annotation       *4.0.0        *4.0.0        *4.0.0        4.0.1        

dev_dependencies:        
freezed                   *3.2.3        *3.2.3        *3.2.3        3.2.4        
json_serializable         *6.11.2       *6.11.2       *6.11.2       6.11.4       
riverpod_generator        *4.0.0+1      *4.0.0+1      *4.0.0+1      4.0.2        

transitive dependencies: 
_fe_analyzer_shared       *91.0.0       (blocked)     (blocked)     93.0.0       
analyzer                  *8.4.1        (blocked)     (blocked)     10.0.1       
sqlite3                   *2.9.4        (blocked)     (blocked)     3.1.3        
```

---

## Next Actions

1. **Wait for Flutter SDK update** — The `test_api` 0.7.7 pin is part of Flutter 3.38.5. A newer Flutter stable release should unblock these upgrades.

2. **Monitor Riverpod/Drift compatibility** — The conflict is between:
   - `riverpod` 3.2.x requiring `test ^1.27.0` (→ `test_api` 0.7.8+)
   - `drift_dev` 2.30.x requiring `test ^1.26.0` (→ `test_api` 0.7.7)

3. **No NEEDS DECISION items** — All packages are at their maximum compatible versions.

---

## Files Modified (This Session)

- `pubspec.yaml` — Updated constraints (reverted incompatible changes)
- Import cleanup completed in previous session

---

## Current `pubspec.yaml` Versions

```yaml
flutter_riverpod: ^3.1.0      # Max compatible
riverpod_annotation: ^4.0.0   # Max compatible
riverpod_generator: ^4.0.0    # Max compatible
drift: ^2.30.0                # Latest
drift_dev: ^2.30.0            # Latest
go_router: ^17.0.0            # Latest
google_fonts: ^7.1.0          # Latest
freezed: ^3.2.0               # Max compatible
json_serializable: ^6.9.5     # Max compatible
```
