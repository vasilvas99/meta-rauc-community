FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

# Ensure file gets updated on each build
do_install[nostamp] = "1"
do_install_basefilesissue[nostamp] = "1"


# Add a mount point for a shared data partition
dirs755 += "/data"
