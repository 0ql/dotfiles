#!/bin/bash

echo -n "Already running in arch-chroot? [Y/n] "
read input
if [[ $input == n ]]; then
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
  arch-chroot /mnt
fi

echo -n "Enter your zoneinfo directory (/usr/share/zoneinfo/...): "
read input

ln -sf $input /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=" >> /etc/vconsole.conf # enter keymap if you don't use the usual one

echo -n "Enter the name you want to give your computer: "
read input

echo $input >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $input.localdomain $input" >> /etc/hosts

pacman -S --noconfirm grub efibootmgr networkmanager base-devel openssh os-prober sudo

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

echo -n "Enter efi directory (/dev/Xda): "
read input

mount --mkdir $input /mnt/boot

grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable sshd

passwd

echo -n "Create new user? [y/N] "
read input

if [[ $input == y ]]; then
  sed -i '85s/.//' /etc/sudoers

  echo -n "Enter username: "
  read input
  useradd -mG wheel $input 
  passwd $input
fi

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
