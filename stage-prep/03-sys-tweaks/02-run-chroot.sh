git clone https://github.com/foundObjects/zram-swap
cd zram-swap
./install.sh
cd ..
rm -rf zram-swap

cat >> ${ROOTFS_DIR}/boot/config.txt << EOF
gpu_mem=16
disable_splash=1

[pi3]

# Disable Bluetooth, it interferes with serial port
dtoverlay=pi3-disable-bt
dtoverlay=pi3-miniuart-bt

force_turbo=1
boot_delay=1

[all]

EOF
