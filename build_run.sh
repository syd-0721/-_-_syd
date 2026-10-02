#!/bin/bash
# ==============================================================================
# build_run.sh - Package myenv/ into a Makeself .run installer
# Run this script IN LINUX (WSL2 or Ubuntu) from the parent directory
#   i.e., from the directory CONTAINING myenv/
#
# Prerequisites: sudo apt install makeself
# ==============================================================================
set -euo pipefail

PACKAGE_DIR="myenv"
OUTPUT_FILE="myenv_installer.run"
LABEL="myenv Ubuntu Setup Package"
ENTRY_SCRIPT="./install.sh"

# ── Preflight checks ─────────────────────────────────────────────────────────
if ! command -v makeself &>/dev/null; then
    echo "[ERROR] makeself not found. Install it: sudo apt install makeself"
    exit 1
fi

if [ ! -d "$PACKAGE_DIR" ]; then
    echo "[ERROR] Directory '$PACKAGE_DIR' not found. Run from parent directory."
    exit 1
fi

# ── Fix line endings & permissions ───────────────────────────────────────────
echo "[INFO] Converting CRLF -> LF and setting permissions..."
bash "$PACKAGE_DIR/convert_line_endings.sh"

# ── Build .run ────────────────────────────────────────────────────────────────
echo "[INFO] Building $OUTPUT_FILE ..."
makeself \
    --gzip \
    "$PACKAGE_DIR" \
    "$OUTPUT_FILE" \
    "$LABEL" \
    "$ENTRY_SCRIPT"

echo ""
echo "[OK] Done! Output: $OUTPUT_FILE"
echo "     Size: $(du -sh "$OUTPUT_FILE" | cut -f1)"
echo ""
echo "Test with:"
echo "  bash $OUTPUT_FILE --list      # list contents only"
echo "  bash $OUTPUT_FILE --noexec    # extract without running"
echo "  bash $OUTPUT_FILE             # full install"
