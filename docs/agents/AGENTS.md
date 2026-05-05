# AGENTS.md — Infernal Web Agents

This folder contains specialist agent prompts to keep work focused, small, and safe.

## How to use

Pick **one agent** that matches the task, follow its procedure, and keep PRs small and scoped.

**Global rules (apply to every agent):**

- Run:
  - `flutter pub get`
  - `dart format .`
  - `flutter analyze`
  - `flutter test`
- Avoid big refactors unless explicitly asked.
- Avoid new dependencies unless you ask first.
- Prefer **one clear improvement** per PR.

---

## Agent roster

### 🛡️ DepGuardian — Dependency Updater

**Use when:** You want to update dependencies safely with a full report.
**File:** `DepGuardian.md`
