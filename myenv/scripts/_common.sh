#!/bin/bash
# ==============================================================================
# _common.sh - Shared utility functions
# Source this file in every sub-script: source "$(dirname "$0")/_common.sh"
# ==============================================================================

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
log_ok()      { echo -e "${GREEN}[OK]${NC}    $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# ── Package Install (idempotent) ──────────────────────────────────────────────
# Usage: pkg_install vim git cmake
pkg_install() {
    local to_install=()
    for pkg in "$@"; do
        if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
            log_info "SKIP: $pkg (already installed)"
        else
            to_install+=("$pkg")
        fi
    done

    if [ ${#to_install[@]} -gt 0 ]; then
        log_info "Installing: ${to_install[*]}"
        sudo apt-get install -y "${to_install[@]}" || {
            log_error "Failed to install: ${to_install[*]}"
            exit 1
        }
        log_ok "Installed: ${to_install[*]}"
    fi
}

# ── apt update (run only once per session) ────────────────────────────────────
apt_update_once() {
    if [ ! -f /tmp/.apt_updated_$$parent ]; then
        log_info "Running apt-get update..."
        sudo apt-get update -y
        touch /tmp/.apt_updated_$$parent
        log_ok "apt-get update done"
    fi
}

# ── Git clone (idempotent) ────────────────────────────────────────────────────
# Usage: git_clone_or_pull <url> <target_dir> [branch]
git_clone_or_pull() {
    local url="$1"
    local dir="$2"
    local branch="${3:-}"

    if [ -d "$dir/.git" ]; then
        log_info "SKIP clone: $dir already exists, pulling latest..."
        git -C "$dir" pull
    else
        if [ -n "$branch" ]; then
            git clone --branch "$branch" --depth 1 "$url" "$dir"
        else
            git clone --depth 1 "$url" "$dir"
        fi
        log_ok "Cloned: $url -> $dir"
    fi
}

# ── cmake build helper ────────────────────────────────────────────────────────
# Usage: cmake_build <source_dir> [extra_cmake_args...]
cmake_build() {
    local src="$1"; shift
    local build_dir="$src/build"

    mkdir -p "$build_dir"
    cmake -S "$src" -B "$build_dir" \
        -DCMAKE_BUILD_TYPE=Release \
        "$@"
    cmake --build "$build_dir" -- -j"$(nproc)"
    sudo cmake --install "$build_dir"
    log_ok "cmake build & install done: $src"
}

# ── Command existence check ───────────────────────────────────────────────────
require_cmd() {
    command -v "$1" &>/dev/null || {
        log_error "Required command not found: $1"
        exit 1
    }
}
