This README file contains information on the contents of the meta-rauc-qemuarm64 layer.

It provides an example meta-layer for integrating UBoot and Rauc for the Qemuarm64 target.
Currently only targets the ``kirkstone`` Yocto branch.


Dependencies
============

This layer depends on:

* URI: git://git.openembedded.org/openembedded-core
* URI: https://github.com/rauc/meta-rauc.git


Main Points
===========

To enable the integration this meta-layer does the following

* Patches the Uboot Sources to save the environment in the FAT /boot partition
* Provides a boot.cmd.in script for the slot counting
* Provides an ``u-boot_%.bbappend`` to compile and install the custom boot command
* Provides a ``*.wks``-kickstart file to partition the drive and an fstab to mount the partitions in the final image
* Provides a grow-data-partition systemd unit for the cases systemd is available.

Building The Qemuarm64 Demo System
==================================

Building the demo system is most easily done using the ``kas`` tool. The file providing the complete kas-config is 
``qemuarm64-demo-minimal.yaml``.

1. Clone this repository

2. ``cd meta-rauc-qemuarm64``

3. Generate example rauc keys following the instructions for the meta-rauc-qemux86 meta-layer:
https://github.com/rauc/meta-rauc-community/tree/master/meta-rauc-qemux86#a-using-kas-tool-to-build

4. To build the image run ``kas build qemuarm64-demo-minimal.yaml``

5. After the build has successfully completed, you can boot into the image by running: ``kas shell qemuarm64-demo-minimal.yaml -c 'runqemu nographic core-image-minimal'``
