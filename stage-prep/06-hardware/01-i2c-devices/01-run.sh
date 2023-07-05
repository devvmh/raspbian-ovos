#!/bin/bash -e

install -v -d -m 0755 "${ROOTFS_DIR}/var/lib/alsa"
install -v -m 0644 files/default-asound.state "${ROOTFS_DIR}/var/lib/alsa/default-asound.state"

install -v -m 0644 files/shairport-sync.conf "${ROOTFS_DIR}/etc/shairport-sync.conf"
install -v -m 0644 files/pulseaudio-system.pa "${ROOTFS_DIR}/etc/pulse/pulseaudio-system.pa"
install -v -m 0644 files/pulseaudio-daemon.conf "${ROOTFS_DIR}/etc/pulse/pulseaudio-daemon.conf"
install -v -m 0644 files/seeed-voicecard-4mic-daemon.conf "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-4mic-daemon.conf"
install -v -m 0644 files/seeed-voicecard-4mic-default.pa "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-4mic-default.pa"
install -v -m 0644 files/seeed-voicecard-8mic-daemon.conf "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-8mic-daemon.conf"
install -v -m 0644 files/seeed-voicecard-8mic-default.pa "${ROOTFS_DIR}/etc/pulse/seeed-voicecard-8mic-default.pa"
install -v -m 0644 files/mycroft-sj201-daemon.conf "${ROOTFS_DIR}/etc/pulse/mycroft-sj201-daemon.conf"
install -v -m 0644 files/mycroft-sj201-default.pa "${ROOTFS_DIR}/etc/pulse/mycroft-sj201-default.pa"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/voicecard"
install -v -m 0644 files/ac108_6mic.state "${ROOTFS_DIR}/etc/voicecard/ac108_6mic.state"
install -v -m 0644 files/ac108_asound.state "${ROOTFS_DIR}/etc/voicecard/ac108_asound.state"
install -v -m 0644 files/wm8960_asound.state "${ROOTFS_DIR}/etc/voicecard/wm8960_asound.state"

install -v -d -m 0755 "${ROOTFS_DIR}/etc/modules-load.d"
install -v -m 0644 files/i2c.conf "${ROOTFS_DIR}/etc/modules-load.d/i2c.conf"
install -v -m 0644 files/alsa-base.conf "${ROOTFS_DIR}/etc/modprobe.d/alsa-base.conf"

install -v -m 0644 files/91-vocalfusion.rules "${ROOTFS_DIR}/etc/udev/rules.d/91-vocalfusion.rules"

# I think this installs some video stuff, but enough audio and not sure what is what
install -v -m 0644 files 99-com.rules "${ROOTFS_DIR}/etc/udev/rules.d/99-com.rules"

install -v -m 0755 files/tas5806-init "${ROOTFS_DIR}/usr/bin/tas5806-init"
install -v -m 0755 files/sj201-reset-led "${ROOTFS_DIR}/usr/bin/sj201-reset-led"
install -v -m 0644 files/99-i2c.rules "${ROOTFS_DIR}/usr/lib/udev/rules.d/99-i2c.rules"
install -v -m 0644 files/xvf3510.conf "${ROOTFS_DIR}/usr/share/pulseaudio/alsa-mixer/profile-sets/xvf3510.conf"

# dbus stuff
install -v -m 0644 files/audio-mpris.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/audio-mpris.conf"
install -v -m 0644 files/ovos.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/ovos.conf"
install -v -m 0644 files/pulseaudio-system.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/pulseaudio-system.conf"
install -v -m 0644 files/shairport-sync-dbus-policy.conf "${ROOTFS_DIR}/etc/dbus-1/system.d/shairport-sync-dbus-policy.conf"
install -v -m 0644 files/shairport-sync-mpris-policy.conf"${ROOTFS_DIR}/etc/dbus-1/system.d/shairport-sync-mpris-policy.conf"
install -v -m 0644 files/spotifyd-mpris-policy.conf"${ROOTFS_DIR}/etc/dbus-1/system.d/spotifyd-mpris-policy.conf"

echo "enable dbus.socket" "${ROOTFS_DIR}/etc/systemd/user-presets/10-ovos-user.preset"
