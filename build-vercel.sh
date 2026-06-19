#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "============================================="
echo "  Starting Vercel Build for Flutter Web      "
echo "============================================="

# 1. Determine Flutter path
FLUTTER_DIR="$HOME/flutter-sdk"

if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Flutter SDK not found in environment. Cloning stable branch..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
else
  echo "Using cached Flutter SDK."
  cd "$FLUTTER_DIR"
  git fetch --depth 1
  git reset --hard origin/stable
  cd -
fi

# 2. Add Flutter to PATH
export PATH="$PATH:$FLUTTER_DIR/bin"

# 3. Verify installation
echo "Flutter version details:"
flutter --version

# 4. Enable web platform
flutter config --enable-web

# 5. Navigate to app directory and build
echo "Navigating to app directory..."
cd app

echo "Fetching packages..."
flutter pub get

echo "Running code generation (build_runner)..."
dart run build_runner build --delete-conflicting-outputs

echo "Building production web bundle..."
flutter build web --release

echo "============================================="
echo "  Build Complete!                            "
echo "============================================="
