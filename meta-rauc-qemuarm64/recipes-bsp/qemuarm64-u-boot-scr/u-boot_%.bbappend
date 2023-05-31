FILESEXTRAPATHS:prepend:qemuarm64 := "${THISDIR}/files:"
SRC_URI:append:qemuarm64 = " \
    file://fw_env.config \
    file://boot.cmd.in \
    file://env_in_fat_qemuarm.patch \
"

DEPENDS:append:qemuarm64 = " bc-native dtc-native swig-native python3-native flex-native bison-native "

require recipes-bsp/qemuarm64-extra.conf

do_configure:append:qemuarm64() {
    sed -e 's/@@KERNEL_IMAGETYPE@@/${KERNEL_IMAGETYPE}/' \
    -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
    "${WORKDIR}/boot.cmd.in" > "${WORKDIR}/boot.cmd"
}

do_compile:append:qemuarm64() {
    ${B}/tools/mkimage -C none -A ${UBOOT_ARCH} -T script -d "${WORKDIR}/boot.cmd" "${UBOOT_ENV}.${UBOOT_ENV_SUFFIX}"
}

do_install:qemuarm64() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
