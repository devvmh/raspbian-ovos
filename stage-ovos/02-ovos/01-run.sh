#!/bin/bash -e

set -exu

install -v -d -m 0755 "${ROOTFS_DIR}/etc/mycroft"
install -v -m 0644 files/mycroft.conf "${ROOTFS_DIR}/etc/mycroft/mycroft.conf"

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"
install -v -m 0755 files/bus-monitor "${ROOTFS_DIR}/home/ovos/.local/bin/bus-monitor"

# log directories
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/state/mycroft"

install -v -m 0644 files/core.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/ocp.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/phal.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/speech.txt "${ROOTFS_DIR}/"
install -v -m 0644 files/voice.txt "${ROOTFS_DIR}/"

on_chroot <<EOF

pip install -r /core.txt
pip install -r /ocp.txt
pip install -r /phal.txt
pip install -r /speech.txt
pip install -r /voice.txt

EOF

rm "${ROOTFS_DIR}/core.txt"
rm "${ROOTFS_DIR}/ocp.txt"
rm "${ROOTFS_DIR}/phal.txt"
rm "${ROOTFS_DIR}/speech.txt"
rm "${ROOTFS_DIR}/voice.txt"
