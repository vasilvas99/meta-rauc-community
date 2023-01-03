============== QEMU-ARM64 ==============

A layer to enable RAUC to function properly under QEMU-ARM64 + UBOOT.

============== Required partition/bsp setup ==============

Example wic + cfg:
https://github.com/vasilvas99/meta-leda/blob/main/meta-leda-distro/wic/qemuarm64.wks

https://github.com/vasilvas99/meta-leda/blob/main/meta-leda-distro/wic/qemuarm64.cfg

Example fstab:

https://github.com/vasilvas99/meta-leda/blob/main/meta-leda-distro/recipes-core/base-files/base-files/qemuarm64/fstab

Example machine config:

https://github.com/vasilvas99/meta-leda/blob/643a61b6aa28b29204870cd3a06c249aca3acb7f/meta-leda-bsp/conf/machine/qemuarm64-extra.conf

and

https://github.com/vasilvas99/meta-leda/blob/643a61b6aa28b29204870cd3a06c249aca3acb7f/meta-leda-bsp/conf/machine/common-qemu-arm.inc


============== Changes ==============

This layer is directly based on the meta-rauc-community rpi4-64 layer. It patches the `qemu_arm64_defconfig` such that UBOOT saves its environment on the first partition of virtio (virtio 0:1) and not the flash.

From this point on the environment can be readily read by/written to from userspace via the fw_printenv/setnev binaries.

