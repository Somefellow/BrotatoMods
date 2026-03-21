#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TOOLS_DIR="$ROOT_DIR/tools"

echo "Fetching latest GDRETools release info..."
RELEASE_JSON=$(curl -fsSL "https://api.github.com/repos/GDRETools/gdsdecomp/releases/latest")

DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -o '"browser_download_url": *"[^"]*linux[^"]*\.zip"' | grep -o 'https://[^"]*' | head -1)

if [[ -z "$DOWNLOAD_URL" ]]; then
    echo "Error: Could not find a Linux zip release URL." >&2
    exit 1
fi

VERSION=$(echo "$RELEASE_JSON" | grep -o '"tag_name": *"[^"]*"' | grep -o '"[^"]*"$' | tr -d '"')
echo "Found version: $VERSION"
echo "Download URL: $DOWNLOAD_URL"

mkdir -p "$TOOLS_DIR"

ZIP_PATH="$TOOLS_DIR/gdre_tools.zip"
echo "Downloading..."
curl -fL -o "$ZIP_PATH" "$DOWNLOAD_URL"

echo "Extracting..."
unzip -o "$ZIP_PATH" -d "$TOOLS_DIR"
rm "$ZIP_PATH"

BINARY=$(find "$TOOLS_DIR" -name "gdre_tools.x86_64" | head -1)
if [[ -z "$BINARY" ]]; then
    echo "Error: gdre_tools.x86_64 not found after extraction." >&2
    exit 1
fi

chmod +x "$BINARY"
echo "Done. Binary ready at: $BINARY"
