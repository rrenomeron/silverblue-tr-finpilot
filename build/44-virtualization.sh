#!/usr/bin/bash

set -eoux pipefail

echo "Installing Virtualization packages"
# Source helper functions
# shellcheck source=/dev/null
source /ctx/build/copr-helpers.sh

dnf5 -y --setopt=install_weak_deps=False install \
    libvirt \
    libvirt-nss \
    cockpit-machines

copr_install_isolated ublue-os/packages ublue-os-libvirt-workarounds

echo "done"