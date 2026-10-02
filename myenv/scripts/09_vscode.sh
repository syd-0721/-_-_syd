#!/bin/bash
# ==============================================================================
# 09_vscode.sh - Visual Studio Code
# Install via Microsoft's official apt repository (auto-updates with system)
# Ref: https://code.visualstudio.com/docs/setup/linux
# ==============================================================================
source "$(dirname "$0")/_common.sh"

# ── Check if already installed ────────────────────────────────────────────────
if command -v code &>/dev/null; then
    log_info "SKIP: VSCode $(code --version | head -1) already installed."
    exit 0
fi

# ── Dependencies ──────────────────────────────────────────────────────────────
pkg_install wget gpg apt-transport-https

# ── Add Microsoft GPG key & repo ─────────────────────────────────────────────
log_info "Adding Microsoft GPG key..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/microsoft-vscode.gpg > /dev/null

log_info "Adding VSCode apt repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft-vscode.gpg] \
https://packages.microsoft.com/repos/vscode stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# ── Install ───────────────────────────────────────────────────────────────────
sudo apt-get update -y
pkg_install code

log_ok "VSCode installed: $(code --version | head -1)"
log_info "Tip: For Remote-SSH (NUC connection):"
log_info "  1. Open VSCode -> Extensions -> search 'Remote - SSH'"
log_info "  2. Or install from CLI: code --install-extension ms-vscode-remote.remote-ssh"
