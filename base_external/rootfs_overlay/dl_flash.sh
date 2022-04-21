#!/bin/sh

SELF_IP=192.168.0.10
HOST_IP=192.168.0.11
DOWNLOAD_DIR=/tmp/download
BOOT_MOUNT_DIR=/tmp/boot
MMC_DEV=/dev/mmcblk0
MMC_BOOT_PART=/dev/mmcblk0p1
ROOT_DIR=/
KERNEL_IMG=Image
ROOTFS_IMG_GZ=rootfs.ext2.gz
MMC_P2_OFFSET=532480

echo "###############################################"
echo "	Starting Raspberry Pi OS update  "
echo "###############################################"

cd $ROOT_DIR
echo "Mounting proc filesystem"
mount proc

if [ $? -ne 0 ] 
then
	echo "error running mount"
	exit 1
fi
	
echo "Configuring ethernet interface"
ifconfig eth0 $SELF_IP up
if [ $? -ne 0 ]
then
	echo "error running ifconfig"
	exit 1
fi

mkdir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

echo "Downloading Kernel image"

tftp -g -r $KERNEL_IMG $HOST_IP
if [ $? -ne 0 ]
then
	echo "error running tftp. Failed to get Image"
	exit 1
fi

echo "Download root filesystem image"

tftp -g -r $ROOTFS_IMG_GZ $HOST_IP
if [ $? -ne 0 ]
then
	echo "error running tftp. Failed to get rootfs.ext2"
	exit 1
fi

echo "modprobe kernel modules"
modprobe mmc_spi

echo "creating /dev/mmc*"
mknod $MMC_DEV b 179 0
mknod $MMC_BOOT_PART b 179 1

echo "Begin RFS flashing"
gunzip -c $ROOTFS_IMG_GZ | dd  of=$MMC_DEV seek=$MMC_P2_OFFSET
if [ $? -ne 0 ]
then
	echo "error dd command failed"
	exit 1
fi

echo "mounting boot partition"
mkdir $BOOT_MOUNT_DIR
mount $MMC_BOOT_PART $BOOT_MOUNT_DIR
if [ $? -ne 0 ] 
then
	echo "error running mount"
	exit 1
fi

# Copy kernel image to boot partition
cp $KERNEL_IMG $BOOT_MOUNT_DIR
umount $BOOT_MOUNT_DIR

echo "OS update completed successfully"

