#!/bin/bash

cat > /etc/fstab << EOF
# Begin /etc/fstab
# file system		mount-point	type	options		dump fsck order
UUID=$BOOT_PART_UUID		  /boot	       ext2 	 defaults	1	1
UUID=$ROOT_PART_UUID		  /	       ext4	 defaults	1	1

# End /etc/fstab
EOF

cat /etc/fstab
