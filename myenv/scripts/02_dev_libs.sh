#!/bin/bash
# ==============================================================================
# 02_dev_libs.sh - Core robotics/CV development libraries
# Eigen3, Ceres Solver, OpenCV, PCL
# ==============================================================================
source "$(dirname "$0")/_common.sh"

apt_update_once

# ── Eigen3 (Linear Algebra) ───────────────────────────────────────────────────
pkg_install libeigen3-dev

# ── Ceres Solver (Non-linear Optimization) ────────────────────────────────────
# Ref: http://ceres-solver.org/installation.html
log_info "Installing Ceres Solver dependencies..."
pkg_install \
    libgoogle-glog-dev \
    libgflags-dev \
    libatlas-base-dev \
    libsuitesparse-dev

pkg_install libceres-dev

# ── OpenCV (Computer Vision) ──────────────────────────────────────────────────
pkg_install libopencv-dev

# ── PCL (Point Cloud Library) ────────────────────────────────────────────────
pkg_install libpcl-dev

log_ok "All dev libraries installed: Eigen3, Ceres, OpenCV, PCL"
