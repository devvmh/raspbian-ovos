#!/bin/bash -e

set -exu

install -v -m 0644 files/system.txt "${ROOTFS_DIR}/"

on_chroot <<EOF

pip install -U pip
pip install -U wheel

pip install -r /system.txt

EOF

rm "${ROOTFS_DIR}/system.txt"
