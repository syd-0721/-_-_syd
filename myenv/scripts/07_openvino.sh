#!/bin/bash
# ==============================================================================
# 07_openvino.sh - Intel OpenVINO Runtime (Archive install method)
# Ref: https://docs.openvino.ai/2024/get-started/install-openvino/install-openvino-archive-linux.html
#
# Target: Ubuntu 24.04 (Noble)
# This follows the official "Archive" installation method (no root required,
# easy to version-pin, easy to remove).
# ==============================================================================
source "$(dirname "$0")/_common.sh"

# ── CONFIG ────────────────────────────────────────────────────────────────────
OPENVINO_VERSION="2024.6.0"
OPENVINO_YEAR="2024"
INSTALL_DIR="/opt/intel/openvino_${OPENVINO_VERSION}"

# Ubuntu 24.04 archive filename
ARCHIVE_NAME="l_openvino_toolkit_ubuntu24_${OPENVINO_VERSION}.0_x86_64.tgz"
DOWNLOAD_URL="https://storage.openvinotoolkit.org/repositories/openvino/packages/${OPENVINO_YEAR}.6/${ARCHIVE_NAME}"

# ── Check if already installed ────────────────────────────────────────────────
if [ -f "$INSTALL_DIR/setupvars.sh" ]; then
    log_info "SKIP: OpenVINO $OPENVINO_VERSION already installed at $INSTALL_DIR"
    exit 0
fi

# ── Dependencies (Ubuntu 24.04) ───────────────────────────────────────────────
pkg_install \
    libtbb-dev \
    libpugixml-dev \
    libnuma1 \
    ocl-icd-opencl-dev

# ── Download (or use local pre-placed archive) ────────────────────────────────
RESOURCES_DIR="$(dirname "$0")/../resources"
LOCAL_ARCHIVE="$RESOURCES_DIR/$ARCHIVE_NAME"

if [ -f "$LOCAL_ARCHIVE" ]; then
    log_info "Using local archive: $(basename "$LOCAL_ARCHIVE")"
else
    log_info "Downloading OpenVINO $OPENVINO_VERSION for Ubuntu 24.04..."
    require_cmd wget
    wget -q --show-progress -O "$LOCAL_ARCHIVE" "$DOWNLOAD_URL" || {
        log_error "Download failed. Try manually:"
        log_error "  URL: $DOWNLOAD_URL"
        log_error "  Save to: myenv/resources/$ARCHIVE_NAME"
        exit 1
    }
fi

# ── Extract & Install ─────────────────────────────────────────────────────────
TMPDIR_OV=$(mktemp -d)
tar -xzf "$LOCAL_ARCHIVE" -C "$TMPDIR_OV"

sudo mkdir -p /opt/intel
sudo mv "$TMPDIR_OV"/l_openvino_* "$INSTALL_DIR"
rm -rf "$TMPDIR_OV"

# Install runtime dependencies using OpenVINO's own script
if [ -f "$INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh" ]; then
    sudo bash "$INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh" -y
fi

# ── Register GPU support (optional but recommended) ───────────────────────────
if [ -f "$INSTALL_DIR/install_dependencies/install_NEO_OCL_driver.sh" ]; then
    log_info "Installing GPU/OpenCL support..."
    sudo bash "$INSTALL_DIR/install_dependencies/install_NEO_OCL_driver.sh" --no-numa -y 2>/dev/null || true
fi

# ── Add to system profile ─────────────────────────────────────────────────────
PROFILE_SCRIPT="/etc/profile.d/openvino.sh"
PROFILE_LINE="source $INSTALL_DIR/setupvars.sh"

if ! grep -qF "$PROFILE_LINE" "$PROFILE_SCRIPT" 2>/dev/null; then
    echo "$PROFILE_LINE" | sudo tee "$PROFILE_SCRIPT" > /dev/null
    log_ok "OpenVINO env added to $PROFILE_SCRIPT (auto-loaded on login)"
fi

log_ok "OpenVINO $OPENVINO_VERSION installed at $INSTALL_DIR"
log_warn "Re-login or run: source $INSTALL_DIR/setupvars.sh"
