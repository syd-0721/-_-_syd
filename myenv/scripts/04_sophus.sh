#!/bin/bash
# ==============================================================================
# 04_sophus.sh - Build & install Sophus from source (Lie Groups)
# Repo: https://github.com/strasdat/Sophus
# NOTE: Requires same Eigen version as g2o - pin to matching tag
# ==============================================================================
source "$(dirname "$0")/_common.sh"

# ── CONFIG ────────────────────────────────────────────────────────────────────
SOPHUS_REPO="https://github.com/strasdat/Sophus.git"
SOPHUS_DIR="/opt/Sophus"
# Using latest HEAD. To pin, add tag arg to git_clone_or_pull below.

# ── Check if already installed ────────────────────────────────────────────────
if [ -d /usr/local/include/sophus ]; then
    log_info "SKIP: Sophus already installed at /usr/local/include/sophus"
    exit 0
fi

# ── Dependencies ──────────────────────────────────────────────────────────────
pkg_install cmake libeigen3-dev libfmt-dev

# ── Clone ────────────────────────────────────────────────────────────────────
sudo mkdir -p "$SOPHUS_DIR"
sudo chown "$USER:$USER" "$SOPHUS_DIR"

git_clone_or_pull "$SOPHUS_REPO" "$SOPHUS_DIR"

# ── Build & Install ───────────────────────────────────────────────────────────
cmake_build "$SOPHUS_DIR" \
    -DBUILD_SOPHUS_TESTS=OFF \
    -DBUILD_SOPHUS_EXAMPLES=OFF

log_ok "Sophus installed (latest HEAD)"
