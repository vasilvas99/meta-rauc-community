# /********************************************************************************
# * Copyright (c) 2022 Contributors to the Eclipse Foundation
# *
# * See the NOTICE file(s) distributed with this work for additional
# * information regarding copyright ownership.
# *
# * This program and the accompanying materials are made available under the
# * terms of the Apache License 2.0 which is available at
# * https://www.apache.org/licenses/LICENSE-2.0
# *
# * SPDX-License-Identifier: Apache-2.0
# ********************************************************************************/
#

SUMMARY = "U-boot boot scripts for QEMU-ARM64"
LICENSE = "Apache-2.0"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
    file://fw_env.config \
    file://boot.cmd.in \
    file://env_in_fat_qemuarm.patch \
"

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
