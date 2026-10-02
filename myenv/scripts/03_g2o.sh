#!/bin/bash
# ==============================================================================
# 03_g2o.sh - Build & install g2o from source (graph optimization)
# Repo: https://github.com/RainerKuemmerle/g2o
# NOTE: Pin to a stable tag - check releases page and update TAG below
# ==============================================================================
source "$(dirname "$0")/_common.sh"

# ── CONFIG ────────────────────────────────────────────────────────────────────
# Using latest HEAD (no version pin). To pin a version, set G2O_TAG to a tag
# and change `git_clone_or_pull` call to: git_clone_or_pull "$G2O_REPO" "$G2O_DIR" "$G2O_TAG"
G2O_REPO="https://github.com/RainerKuemmerle/g2o.git"
G2O_DIR="/opt/g2o"

# ── Check if already installed ────────────────────────────────────────────────
if [ -f /usr/local/lib/libg2o_core.so ] || [ -f /usr/local/lib/libg2o_core.a ]; then
    log_info "SKIP: g2o appears to be already installed."
    exit 0
fi

# ── Dependencies ──────────────────────────────────────────────────────────────
pkg_install \
    cmake \
    libeigen3-dev \
    libsuitesparse-dev \
    qtdeclarative5-dev \
    qt5-qmake \
    libqglviewer-dev-qt5

# ── Clone ────────────────────────────────────────────────────────────────────
sudo mkdir -p "$G2O_DIR"
sudo chown "$USER:$USER" "$G2O_DIR"

git_clone_or_pull "$G2O_REPO" "$G2O_DIR"

# ── Build & Install ───────────────────────────────────────────────────────────
cmake_build "$G2O_DIR" \
    -DG2O_BUILD_EXAMPLES=OFF \
    -DG2O_BUILD_APPS=OFF

sudo ldconfig
log_ok "g2o installed (latest HEAD)"
