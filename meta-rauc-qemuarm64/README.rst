This README file contains information on the contents of the meta-rauc-qemuarm64 layer.

It provides an example meta-layer for integrating UBoot and Rauc for the qemuarm64 target.
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

Building The qemuarm64 Demo System
==================================

Building the demo system is most easily done using the ``kas`` tool. The file providing the complete kas-config is 
``qemuarm64-demo-minimal.yaml``.

1. Clone this repository

2. ``cd meta-rauc-qemuarm64``

3. Generate example rauc keys following the instructions for the meta-rauc-qemux86 meta-layer: https://github.com/rauc/meta-rauc-community/tree/master/meta-rauc-qemux86#a-using-kas-tool-to-build

4. To build the image run ``kas build qemuarm64-demo-minimal.yaml``

5. After the build has successfully completed, you can boot into the image by running::

   $ kas shell qemuarm64-demo-minimal.yaml -c 'runqemu nographic core-image-minimal'

Installing the Demo bundle
==========================

This is again based on: https://github.com/vasilvas99/meta-rauc-community/tree/master/meta-rauc-qemux86#iv-build-and-install-the-demo-bundle

Running the build with kas will automatically generate a bundle in ``build/tmp/deploy/images/qemuarm64``.

1. Start the qemuarm64 system with user-level networking (slirp)::

   $ kas shell qemuarm64-demo-minimal.yaml -c 'runqemu nographic slirp core-image-minimal'

2. After the system has successfully booted, loogin and run: ``udhcpc -i eth0`` to obtain an IP address.

3. In a seperate terminal copy the bundle to the running image using scp::

   $ scp -P 2222 build/tmp/deploy/images/qemuarm64/core-bundle-minimal-qemuarm64.raucb root@localhost:/home/root
   
4. Go back to the terminal with the running qemuarm64 image and run::

   # rauc install /home/root/core-bundle-minimal-qemuarm64.raucb

5. Wait for the bundle to install successfully and reboot the system.
