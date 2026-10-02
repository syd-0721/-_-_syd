#!/bin/bash
# ==============================================================================
# 01_base_packages.sh - Base system packages
# From requirements: ssh, vim, cutecom, git, g++, cmake, can-utils, etc.
# ==============================================================================
source "$(dirname "$0")/_common.sh"

apt_update_once

# ── SSH Server ────────────────────────────────────────────────────────────────
pkg_install openssh-server

if ! sudo ufw status | grep -q "22/tcp\|OpenSSH"; then
    log_info "Configuring UFW for SSH..."
    sudo ufw allow ssh
    log_ok "UFW SSH rule added"
else
    log_info "SKIP: UFW SSH rule already exists"
fi

# Enable & start SSH
sudo systemctl enable ssh --now
log_ok "SSH server enabled and running"

# ── Terminal & Basic Tools ────────────────────────────────────────────────────
pkg_install \
    vim \
    git \
    g++ \
    cmake \
    screen

# ── Serial Port Tool ─────────────────────────────────────────────────────────
pkg_install cutecom

# ── CAN Bus Utilities ─────────────────────────────────────────────────────────
pkg_install can-utils

# ── Common build dependencies ─────────────────────────────────────────────────
pkg_install \
    libfmt-dev \
    libspdlog-dev \
    libyaml-cpp-dev \
    libusb-1.0-0-dev \
    nlohmann-json3-dev

log_ok "All base packages installed."
