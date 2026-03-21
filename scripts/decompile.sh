#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TOOLS_DIR="$ROOT_DIR/tools"
PCK_DIR="$ROOT_DIR/original_pck"
OUTPUT_DIR="$ROOT_DIR/recovered"

BINARY=$(find "$TOOLS_DIR" -name "gdre_tools.x86_64" 2>/dev/null | head -1)
if [[ -z "$BINARY" ]]; then
    echo "Error: gdre_tools.x86_64 not found in $TOOLS_DIR. Run scripts/init.sh first." >&2
    exit 1
fi

BASE_PCK="$PCK_DIR/Brotato.pck"
if [[ ! -f "$BASE_PCK" ]]; then
    echo "Error: Base game not found at $BASE_PCK" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "Decompiling base game: Brotato.pck..."
"$BINARY" --headless "--recover=$BASE_PCK" "--output=$OUTPUT_DIR"

while IFS= read -r -d '' pck; do
    name="$(basename "$pck")"
    if [[ "$name" == "Brotato.pck" ]]; then
        continue
    fi
    echo "Decompiling DLC: $name..."
    "$BINARY" --headless "--recover=$pck" "--output=$OUTPUT_DIR"
done < <(find "$PCK_DIR" -maxdepth 1 -name "*.pck" -print0)

echo "Done. Decompiled files are in: $OUTPUT_DIR"
