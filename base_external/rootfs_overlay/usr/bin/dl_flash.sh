#!/bin/sh

SELF_IP=192.168.0.10
HOST_IP=192.168.0.11
DOWNLOAD_DIR=/tmp/download
ROOT_DIR=/
cd $ROOT_DIR
echo "Mounting proc filesystem"
mount proc

if [ $? -ne 0 ] 
then
	echo "error running mount"
	exit -1
fi
	
echo "Configuring ethernet interface"
ifconfig eth0 $SELF_IP up
if [ $? -ne 0 ]
then
	echo "error running ifconfig"
	exit -1
fi

mkdir $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

echo "Downloading Kernel and RFS files"
tftp -g -r Image $HOST_IP
if [ $? -ne 0 ]
then
	echo "error running tftp. Failed to get Image"
	exit -1
fi

tftp -g -r rootfs.ext2 $HOST_IP
if [ $? -ne 0 ]
then
	echo "error running tftp. Failed to get rootfs.ext2"
	exit -1
fi

echo "modprobe kernel modules"
modprobe mmc_spi

echo "creating /dev/mmc*"
mknod /dev/mmcblk0 b 179 0
mknod /dev/mmcblk0p1 b 179 1

echo "Begin RFS flashing"
dd if=rootfs.ext2 of=/dev/mmcblk0 seek=532480
if [ $? -ne 0 ]
then
	echo "error dd command failed"
	exit -1
fi

echo "mounting boot partition"
mkdir /tmp/boot
mount /dev/mmcblk0p1 /tmp/boot
if [ $? -ne 0 ] 
then
	echo "error running mount"
	exit -1
fi
# Copy kernel image to boot partition
cp Image /tmp/boot
umount /tmp/boot
echo "OS update completed successfully"


:q

:wq

