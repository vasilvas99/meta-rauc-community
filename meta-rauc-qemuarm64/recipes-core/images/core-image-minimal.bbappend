do_image_wic[depends] += "mtools-native:do_populate_sysroot dosfstools-native:do_populate_sysroot virtual/bootloader:do_deploy"

IMAGE_INSTALL:append = " kernel-image kernel-modules e2fsprogs parted"
EXTRA_IMAGEDEPENDS += "u-boot"

require conf/machine/qemuarm64-extra.conf
