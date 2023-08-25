#!/bin/bash -e

#######################################
#
# WIP #
#
# Deciding on what package is better
#
#######################################

# on_chroot << EOF
#
# curl -sL https://dtcooper.github.io/raspotify/install.sh | bash
#
# EOF
#
# echo "enable raspotify" >> "${ROOTFS_DIR}/etc/systemd/system-preset/10-ovos-system.preset"

curl https://sh.rustup.rs -sSf | sh -s -- -y

# wget https://github.com/Spotifyd/spotifyd/releases
