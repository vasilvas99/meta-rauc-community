EXTRA_IMAGEDEPENDS += "u-boot"
do_image_wic[depends] += "mtools-native:do_populate_sysroot dosfstools-native:do_populate_sysroot virtual/bootloader:do_deploy"

require conf/machine/qemuarm64-extra.conf
