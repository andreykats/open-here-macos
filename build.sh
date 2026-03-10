#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DIST_DIR="$SCRIPT_DIR/dist"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

build_app() {
    local name="$1"
    local script="$2"
    local bundle_id="$3"
    local icon_src="$4"
    local app_path="$DIST_DIR/$name.app"

    echo "Building $name..."
    osacompile -o "$app_path" "$SCRIPT_DIR/scripts/$script"

    # Patch Info.plist
    local plist="$app_path/Contents/Info.plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleName $name" "$plist"
    /usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string $bundle_id" "$plist" 2>/dev/null \
        || /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier $bundle_id" "$plist"

    # Remove compiled asset catalog so .icns icon is used
    rm -f "$app_path/Contents/Resources/Assets.car"

    # Copy icon if source exists
    if [ -f "$icon_src" ]; then
        cp "$icon_src" "$app_path/Contents/Resources/applet.icns"
        echo "  Icon: copied from $icon_src"
    else
        echo "  Icon: using default (source not found: $icon_src)"
    fi

    # Ad-hoc code sign
    codesign --force --sign - "$app_path"

    echo "  -> $app_path"
}

build_app "Open in VSCode" "open-in-vscode.applescript" "com.andrey.open-in-vscode" \
    "$SCRIPT_DIR/icons/vscode.icns"

build_app "Open in iTerm" "open-in-iterm.applescript" "com.andrey.open-in-iterm" \
    "$SCRIPT_DIR/icons/terminal.icns"

echo ""
echo "Done! Apps are in $DIST_DIR/"
echo "To install: Cmd+drag each .app into your Finder toolbar."
