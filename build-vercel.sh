#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "============================================="
echo "  Starting Vercel Build for Flutter Web      "
echo "============================================="

# 1. Determine Flutter path
if command -v flutter &> /dev/null; then
  echo "Using existing Flutter SDK found in PATH."
else
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
fi

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

# 6. Prepare Vercel Build Output API v3 structure
echo "Preparing Vercel Build Output API v3 structure..."
cd .. # Go back to root from app/

# Clean any existing .vercel/output directory
rm -rf .vercel/output

# Create the static folder in the .vercel/output directory
mkdir -p .vercel/output/static

# Copy all build assets from app/build/web to .vercel/output/static
cp -R app/build/web/. .vercel/output/static/

# Generate the config.json for Build Output API v3
cat <<'EOT' > .vercel/output/config.json
{
  "version": 3,
  "routes": [
    {
      "handle": "filesystem"
    },
    {
      "src": "/((?!assets/|.*\\..*$).*)",
      "dest": "/index.html"
    }
  ]
}
EOT

echo "Vercel Build Output API v3 structure prepared successfully!"

echo "============================================="
echo "  Build Complete!                            "
echo "============================================="
