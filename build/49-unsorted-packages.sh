#!/usr/bin/bash

set -eou pipefail

# Notes: The Gnome Extensions and fonts will move out of this script
# once we get Bluebuild modules working

dnf5 -y install \
    gnome-tweaks \
    intel-one-mono-fonts 