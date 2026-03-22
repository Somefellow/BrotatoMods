#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
MODS_UNPACKED_DIR="$ROOT_DIR/recovered/mods-unpacked"
OUTPUT_DIR="$ROOT_DIR/mods"

if [[ ! -d "$MODS_UNPACKED_DIR" ]]; then
    echo "Error: $MODS_UNPACKED_DIR does not exist. Run scripts/decompile.sh first." >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

for mod_dir in "$MODS_UNPACKED_DIR"/*/; do
    mod_name="$(basename "$mod_dir")"
    zip_path="$OUTPUT_DIR/$mod_name.zip"

    echo "Packing $mod_name..."

    mkdir -p "$tmp/mods-unpacked"
    cp -r "$mod_dir" "$tmp/mods-unpacked/$mod_name"

    (cd "$tmp" && zip -r "$zip_path" "mods-unpacked/$mod_name" --quiet)

    rm -rf "$tmp/mods-unpacked"
done

echo "Done. Zips written to: $OUTPUT_DIR"
