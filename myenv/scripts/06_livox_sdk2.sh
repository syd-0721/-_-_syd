#!/bin/bash
# ==============================================================================
# 06_livox_sdk2.sh - Livox SDK2 for Mid-360 LiDAR
# Repo: https://github.com/Livox-SDK/Livox-SDK2
# ==============================================================================
source "$(dirname "$0")/_common.sh"

LIVOX_REPO="https://github.com/Livox-SDK/Livox-SDK2.git"
LIVOX_DIR="/opt/Livox-SDK2"

# ── Check if already installed ────────────────────────────────────────────────
if ldconfig -p | grep -q "liblivox_lidar_sdk_shared"; then
    log_info "SKIP: Livox SDK2 already installed."
    exit 0
fi

# ── Dependencies ──────────────────────────────────────────────────────────────
pkg_install cmake libapr1-dev libboost-all-dev

# ── Clone ────────────────────────────────────────────────────────────────────
sudo mkdir -p "$LIVOX_DIR"
sudo chown "$USER:$USER" "$LIVOX_DIR"

git_clone_or_pull "$LIVOX_REPO" "$LIVOX_DIR"

# ── Build & Install ───────────────────────────────────────────────────────────
cmake_build "$LIVOX_DIR"

sudo ldconfig
log_ok "Livox SDK2 installed."
