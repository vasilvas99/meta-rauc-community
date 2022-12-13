FILESEXTRAPATHS:prepend:rpi := "${THISDIR}/files:"
SRC_URI:append:rpi = " file://qemuarm64-rauc.rules"

do_install:append:rpi() {
    install -m 0644 ${WORKDIR}/qemuarm64-rauc.rules ${D}${sysconfdir}/udev/mount.blacklist.d/
}
