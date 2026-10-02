#!/bin/bash
# ==============================================================================
# 05_galaxy_sdk.sh - Daheng Imaging Galaxy Linux SDK
# Download page: https://www.daheng-imaging.com/downloads/
#
# USAGE: Place the downloaded SDK zip in the resources/ folder.
#   Expected file: Galaxy_Linux-x86_Gige-U3_32bits-64bits_*.zip
#
# The zip contains a directory with an install script inside.
# ==============================================================================
source "$(dirname "$0")/_common.sh"

RESOURCES_DIR="$(dirname "$0")/../resources"

# ── Find SDK archive (.zip) ───────────────────────────────────────────────────
SDK_FILE=$(find "$RESOURCES_DIR" -name "Galaxy_Linux*.zip" 2>/dev/null | head -1)

if [ -z "$SDK_FILE" ]; then
    log_warn "Galaxy SDK zip not found in resources/."
    log_warn "Please download from: https://www.daheng-imaging.com/downloads/"
    log_warn "  Product: Galaxy Linux-x86 GigE&U3 SDK"
    log_warn "  Place the .zip into: myenv/resources/"
    log_warn "Skipping Galaxy SDK installation."
    exit 0
fi

# ── Check if already installed ────────────────────────────────────────────────
if ldconfig -p | grep -q "libgxiapi"; then
    log_info "SKIP: Galaxy SDK (libgxiapi) already installed."
    exit 0
fi

log_info "Found SDK: $(basename "$SDK_FILE")"

# ── Dependency: unzip ─────────────────────────────────────────────────────────
pkg_install unzip

# ── Extract zip ───────────────────────────────────────────────────────────────
TMPDIR_SDK=$(mktemp -d)
log_info "Extracting to $TMPDIR_SDK ..."
unzip -q "$SDK_FILE" -d "$TMPDIR_SDK"

# ── Find the install script ───────────────────────────────────────────────────
# Galaxy SDK zip usually extracts to a subdirectory containing install.sh
INSTALL_SCRIPT=$(find "$TMPDIR_SDK" -name "install.sh" | head -1)

if [ -z "$INSTALL_SCRIPT" ]; then
    # Fallback: look for any .sh script
    INSTALL_SCRIPT=$(find "$TMPDIR_SDK" -name "*.sh" | head -1)
fi

if [ -z "$INSTALL_SCRIPT" ]; then
    log_error "Could not find install script inside Galaxy SDK archive."
    log_error "Contents:"
    find "$TMPDIR_SDK" -maxdepth 3 | head -30
    rm -rf "$TMPDIR_SDK"
    exit 1
fi

log_info "Found install script: $INSTALL_SCRIPT"
chmod +x "$INSTALL_SCRIPT"

# Galaxy SDK installer: run with -s for silent (non-interactive) mode
# The script must be run from its own directory
cd "$(dirname "$INSTALL_SCRIPT")"
sudo bash "$(basename "$INSTALL_SCRIPT")" -s

cd - > /dev/null
rm -rf "$TMPDIR_SDK"
sudo ldconfig

log_ok "Galaxy SDK installed."
