#!/bin/bash -e

set -exu

on_chroot <<EOF

chown -Rv ovos:ovos /home/ovos
chmod -Rv +x /home/ovos/.local/bin/*

EOF
