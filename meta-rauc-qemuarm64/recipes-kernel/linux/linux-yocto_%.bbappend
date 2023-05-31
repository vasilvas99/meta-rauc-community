SUMMARY = "QEMU Virtual Device Support"
DESCRIPTION = "Enables support for QEMU emulated devices"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-yocto:"
SRC_URI:append:qemuarm64 = " file://qemu-virtio.cfg"

# According to https://wiki.yoctoproject.org/wiki/License_Infrastructure_Interest_Group
LICENSE = "Apache-2.0"
