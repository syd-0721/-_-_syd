#!/bin/bash
# ==============================================================================
# install.sh - Main Entry Point
# Ubuntu 22.04 / 24.04 Environment Setup
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
log_ok()      { echo -e "${GREEN}[OK]${NC}    $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }
log_section() { echo -e "\n${BOLD}${BLUE}===== $* =====${NC}"; }

# ── Compatibility Check ───────────────────────────────────────────────────────
check_os() {
    if [ ! -f /etc/os-release ]; then
        log_error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
    . /etc/os-release
    if [[ "$ID" != "ubuntu" ]]; then
        log_warn "This script is designed for Ubuntu. Detected: $ID $VERSION_ID"
        read -rp "Continue anyway? [y/N] " ans
        [[ "$ans" =~ ^[Yy]$ ]] || exit 1
    fi
    log_info "OS: $PRETTY_NAME"
}

# ── Sudo Check ────────────────────────────────────────────────────────────────
check_sudo() {
    if ! sudo -v &>/dev/null; then
        log_error "sudo privileges required."
        exit 1
    fi
    # Keep sudo alive throughout script
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
    echo -e "${BOLD}"
    echo "╔══════════════════════════════════════════╗"
    echo "║     System Environment Setup Script      ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"

    check_os
    check_sudo

    log_section "Step 1: System Base Packages"
    bash "$SCRIPT_DIR/scripts/01_base_packages.sh"

    log_section "Step 2: Development Libraries (Eigen / Ceres / OpenCV / PCL)"
    bash "$SCRIPT_DIR/scripts/02_dev_libs.sh"

    log_section "Step 3: g2o (Graph Optimization)"
    bash "$SCRIPT_DIR/scripts/03_g2o.sh"

    log_section "Step 4: Sophus (Lie Groups)"
    bash "$SCRIPT_DIR/scripts/04_sophus.sh"

    log_section "Step 5: Daheng Galaxy SDK"
    bash "$SCRIPT_DIR/scripts/05_galaxy_sdk.sh"

    log_section "Step 6: Livox SDK2 (Mid-360 LiDAR)"
    bash "$SCRIPT_DIR/scripts/06_livox_sdk2.sh"

    log_section "Step 7: OpenVINO Runtime"
    bash "$SCRIPT_DIR/scripts/07_openvino.sh"

    log_section "Step 8: VSCode"
    bash "$SCRIPT_DIR/scripts/09_vscode.sh"

    log_section "Step 9: NoMachine Remote Desktop (Optional)"
    bash "$SCRIPT_DIR/scripts/08_nomachine.sh"

    echo -e "\n${GREEN}${BOLD}"
    echo "╔══════════════════════════════════════════╗"
    echo "║        All Steps Completed!              ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    log_warn "Please REBOOT the system to apply all changes."
}

main "$@"
