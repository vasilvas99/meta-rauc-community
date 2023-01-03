SUMMARY = "U-boot boot scripts for Raspberry Pi"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"


FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
    file://fw_env.config \
    file://boot.cmd.in \
    file://env_in_fat_qemuarm.patch \
"


# FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
DEPENDS += " bc-native dtc-native swig-native python3-native flex-native bison-native "


UBOOT_ENV_SUFFIX = "scr"
UBOOT_ENV = "boot"

do_configure:append() {
    sed -e 's/@@KERNEL_IMAGETYPE@@/${KERNEL_IMAGETYPE}/' \
    -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
    "${WORKDIR}/boot.cmd.in" > "${WORKDIR}/boot.cmd"
}

inherit rauc-integration

do_compile:append() {
    ${B}/tools/mkimage -C none -A ${UBOOT_ARCH} -T script -d "${WORKDIR}/boot.cmd" "boot.scr"
}

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}


