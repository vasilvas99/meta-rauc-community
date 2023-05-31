EXTRA_IMAGEDEPENDS += "u-boot"
do_image_wic[depends] += "mtools-native:do_populate_sysroot dosfstools-native:do_populate_sysroot virtual/bootloader:do_deploy"

require recipes-bsp/qemuarm64-extra.conf