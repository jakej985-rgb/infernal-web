#!/usr/bin/env bash
# ==============================================================================
# Infernal Web - Production Web Release Build Script for M3tal-Hub
# ==============================================================================
set -euo pipefail

BASE_HREF="${1:-/infernal-web/}"
echo "============================================="
echo "Building Infernal Web (Flutter Web Release)"
echo "Base HREF: ${BASE_HREF}"
echo "============================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${ROOT_DIR}/app"

echo "Resolving Flutter dependencies..."
flutter pub get

echo "Running code generation (build_runner)..."
dart run build_runner build --delete-conflicting-outputs

echo "Compiling Flutter Web release..."
flutter build web --release --base-href "${BASE_HREF}"

echo "Moving build output to repository root /build/web..."
cd "${ROOT_DIR}"
rm -rf build/web
mkdir -p build
cp -r app/build/web build/web

test -f build/web/index.html || {
  echo "Error: build/web/index.html was not generated!" >&2
  exit 1
}

echo "Infernal Web release build completed successfully at build/web/."
