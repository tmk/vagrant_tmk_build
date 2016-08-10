#! /bin/sh

# change password for console login
echo -n "ubuntu:ubuntu" | chpasswd

# add local host entry to resolver
grep $(hostname) /etc/hosts > /dev/null 2>&1 || echo "127.0.0.1 $(hostname)" >> /etc/hosts

#
# install tools
#
apt-get update
apt-get upgrade
apt-get install -y git unzip build-essential
# for AVR
apt-get install -y make gcc-avr avr-libc binutils-avr dfu-programmer
# for ARM Cortex-M
apt-get install -y binutils-arm-none-eabi gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib dfu-util
# for USB HID kernel modlue - /dev/hidraw devices required by hid_listen
apt-get install -y linux-image-extra-virtual
# clean cached files
apt-get autoremove
apt-get clean

# add udev rules for keyboard and bootloaders
cat > /etc/udev/rules.d/99-tmk.rules <<EOF
# tmk keyboard products     https://github.com/tmk/tmk_keyboard
SUBSYSTEMS=="usb", ATTRS{idVendor}=="feed", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="feed", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="feed", MODE:="0666"
EOF

cat > /etc/udev/rules.d/99-atmel.rules <<EOF
# Atmel ATMega32U4
SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff4", MODE:="0666"

# Atmel ATMega32U2
SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ff0", MODE:="0666"

# Atmel AT90usb
SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2ffb", MODE:="0666"
EOF

cat > /etc/udev/rules.d/99-teensy.rules <<EOF
# https://www.pjrc.com/teensy/49-teensy.rules
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", MODE:="0666"
EOF

cat > /etc/udev/rules.d/99-kiibohd.rules <<EOF
# https://github.com/kiibohd/controller/blob/master/98-kiibohd.rules

# Kiibohd Serial Interface
SUBSYSTEM=="tty", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b04d", SYMLINK+="kiibohd", MODE:="0666"

# Kiibohd DFU Bootloader
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1C11", ATTRS{idProduct}=="b007", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1C11", ATTRS{idProduct}=="b007", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1c11", ATTRS{idProduct}=="b007", MODE:="0666"
EOF

cat > /etc/udev/rules.d/99-mchck.rules <<EOF
# DFU Bootloader (MCHCK)
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2323", ENV{ID_MM_DEVICE_IGNORE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2323", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2323", MODE:="0666"
EOF

cat > /etc/udev/rules.d/99-kinetis.rules <<EOF
# NXP/Freescale Kinetis KL27Z bootlaoder
SUBSYSTEMS=="usb", ATTRS{idVendor}=="15a2", ATTRS{idProduct}=="0073", MODE:="0666"
EOF
