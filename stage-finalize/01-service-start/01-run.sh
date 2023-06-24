#/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local"
install -v -d -m 0755 "${ROOTFS_DIR}/home/ovos/.local/bin"

on_chroot << EOF

chown -Rf ovos:ovos /home/ovos

systemctl set-default multi-user.target

systemctl preset-all

cat /etc/passwd | grep -i ovos

su -c "systemctl --user preset-all" --login ovos

EOF
