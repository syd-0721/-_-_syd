#!/bin/bash
# ==============================================================================
# 08_nomachine.sh - NoMachine Remote Desktop (Optional)
# ==============================================================================
source "$(dirname "$0")/_common.sh"

# ── CONFIG ────────────────────────────────────────────────────────────────────
NX_VERSION="8.14.1_1"
NX_ARCH="amd64"
NX_DEB="nomachine_${NX_VERSION}_${NX_ARCH}.deb"
NX_URL="https://download.nomachine.com/download/8.14/Linux/${NX_DEB}"

RESOURCES_DIR="$(dirname "$0")/../resources"
LOCAL_DEB="$RESOURCES_DIR/$NX_DEB"

# ── Check if already installed ────────────────────────────────────────────────
if dpkg -l nomachine 2>/dev/null | grep -q "^ii"; then
    log_info "SKIP: NoMachine already installed."
    exit 0
fi

# ── Optional prompt ───────────────────────────────────────────────────────────
read -rp "Install NoMachine remote desktop? [y/N] " ans
[[ "$ans" =~ ^[Yy]$ ]] || { log_info "Skipping NoMachine."; exit 0; }

# ── Download or use local copy ────────────────────────────────────────────────
if [ -f "$LOCAL_DEB" ]; then
    log_info "Using local package: $LOCAL_DEB"
else
    log_info "Downloading NoMachine $NX_VERSION..."
    require_cmd wget
    wget -q --show-progress -O "$LOCAL_DEB" "$NX_URL" || {
        log_error "Download failed. Get it from: https://www.nomachine.com/download"
        exit 1
    }
fi

# ── Install ───────────────────────────────────────────────────────────────────
sudo dpkg -i "$LOCAL_DEB"
sudo apt-get -f install -y   # fix any dependency issues

log_ok "NoMachine installed."
log_info "Start/stop: sudo /etc/NX/nxserver --start / --stop"
