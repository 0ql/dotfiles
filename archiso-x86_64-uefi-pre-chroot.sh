#!/bin/bash

timedatectl set-ntp true
fdisk -l
echo -n "Enter the disk path you want to format (/dev/Xda): "
read input
fdisk $input
echo -n "Enter the EFI disk partition path (/dev/Xda): "
read efipartition
mkfs.fat -F32 $efipartition
echo -n "Enter the Linux Filesystem disk partition path (/dev/Xda): "
read input
mkfs.ext4 $input
mount $input /mnt
pacstrap /mnt base linux linux-firmware sudo
genfstab -U /mnt >> /mnt/etc/fstab
mv ./arch-x86_64-uefi-post-chroot.sh /mnt
arch-chroot /mnt
