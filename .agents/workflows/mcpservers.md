---
description: use mcp server needed
---

# 🧠 Infernal Web MCP Workflow

## 🎯 Purpose

This workflow enables intelligent, automatic use of MCP servers based on task type.
The agent MUST follow this routing logic instead of guessing tools.

---

# 🔀 TOOL SELECTION ENGINE

## 1. 🧩 Code / Repo Tasks → `github-mcp-server`

Use when:

* Reading repo files
* Creating PRs
* Refactoring code
* Debugging app issues
* Reviewing structure

### Examples

* "Fix provider dispose crash"
* "Refactor appointments feature"
* "Audit repo"

---

## 2. 📁 Local File Access → `filesystem`

Use when:

* Reading local project files
* Inspecting logs
* Accessing mounted repo at:

  * `/media/m3tal/Ventoy/github`

### Examples

* "Open appointment_controller.dart"
* "Check logs"
* "Read config files"

---

## 3. ☁️ Firebase Tasks → `firebase-mcp-server`

Use when:

* Firestore queries
* Auth debugging
* Deploying Firebase Hosting
* Emulator work

### Examples

* "Check users collection"
* "Deploy Firebase"
* "Fix auth issue"

---

## 4. 🚀 Cloud Run → `cloudrun`

Use when:

* Deploying backend services
* Checking service logs
* Managing APIs

### Examples

* "Deploy API"
* "Check Cloud Run logs"
* "Update service"

---

## 5. 🐳 Containers → `docker`

Use when:

* Running containers
* Debugging container builds
* Managing local dev environments

### Examples

* "Run API locally"
* "Check container logs"

---

## 6. 📊 Data / Visualization → `visualization`

Use when:

* Viewing structured data
* Debugging analytics
* Rendering charts

---

## 7. 📓 Notebook / Data Science → `notebooks`

Use when:

* Running experiments
* Data exploration
* AI/ML workflows

---

## 8. 🧠 Complex Reasoning → `sequential-thinking`

Use when:

* Multi-step debugging
* Architecture planning
* Refactor strategies

### Examples

* "Why does provider crash?"
* "Design system architecture"

---

## 9. 🎯 Dart / Flutter Tasks → `dart-mcp-server`

Use when:

* Running Dart analysis
* Formatting code
* Static checks

### Examples

* "Analyze project"
* "Fix lint errors"

---

# 🧭 PRIORITY RULES (CRITICAL)

## Rule 1: Always prefer SOURCE over GUESSING

* If code exists → use GitHub or filesystem
* DO NOT hallucinate code

---

## Rule 2: Separate UI vs Backend tools

* Flutter UI → GitHub / filesystem
* Firebase → firebase-mcp-server
* API → cloudrun

---

## Rule 3: NEVER mix responsibilities

Bad:

* Using Firebase tool to debug UI

Good:

* UI issue → GitHub
* Data issue → Firebase

---

## Rule 4: Debugging flow (MANDATORY)

### Step 1: Inspect code

→ github-mcp-server OR filesystem

### Step 2: Analyze logic

→ sequential-thinking

### Step 3: Validate backend

→ firebase-mcp-server / cloudrun

### Step 4: Apply fix

→ github-mcp-server

---

# 🔁 COMMON WORKFLOWS

---

## 🧨 Fix Bug (EX: provider dispose crash)

1. Read file → github-mcp-server
2. Trace logic → sequential-thinking
3. Identify async misuse
4. Patch code → github-mcp-server

---

## 🔥 Deploy App

1. Build backend → docker
2. Deploy API → cloudrun
3. Deploy frontend → firebase-mcp-server

---

## 📊 Debug Data Issue

1. Inspect Firestore → firebase-mcp-server
2. Compare with UI → github-mcp-server
3. Fix mismatch

---

## 🧱 Refactor Feature

1. Read feature → github-mcp-server
2. Plan architecture → sequential-thinking
3. Implement controllers → github-mcp-server
4. Validate → dart-mcp-server

---

# 🚫 ANTI-PATTERNS (DO NOT DO)

* ❌ Guess code without reading repo
* ❌ Use wrong server for task
* ❌ Mix UI + backend debugging
* ❌ Skip sequential-thinking for complex bugs

---

# ⚡ OPTIMIZATION RULES

* Prefer filesystem for local speed
* Use GitHub for repo-wide context
* Use sequential-thinking BEFORE major changes
* Cache mental model of repo structure

---

# 🧠 AGENT MINDSET

The agent should behave like:

> “Locate → Understand → Reason → Execute”

NOT:

> “Guess → Try → Fail”

---

# ✅ SUCCESS CRITERIA

The workflow is correct if:

* Tools are used deterministically
* Bugs are reproducible before fixing
* Code changes are minimal and precise
* No hallucinated logic is introduced

---

# 🔥 FINAL NOTE

This system is designed for:

* Flutter + Firebase + Cloud Run apps
* Multi-layer debugging
* Production-grade workflows

Follow it strictly to avoid instability.
