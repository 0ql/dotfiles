#!/bin/bash

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

pacman -S --noconfirm grub efibootmgr networkmanager base-devel os-prober sudo

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

echo -n "Enter efi directory (/dev/Xda): "
read input

mount --mkdir $input /mnt/boot

grub-install --target=x86_64-efi --efi-directory=/mnt/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

passwd

echo -n "Create new user? [y/N] "
read input

if [[ $input == y ]]; then
  sed -i '85s/.//' /etc/sudoers

  echo -n "Enter username: "
  read username
  useradd -mG wheel $username
  passwd $username

  echo -n "Download (but not install) 0ql/dotfiles repository for user $username? [y/N] "
  read input

  if [[ $input == y ]]; then
    sudo pacman -S --noconfirm git
    cd /home/$username
    git clone https://github.com/0ql/dotfiles.git
  fi
fi

cd /
echo -n "Remove post install script? [Y/n] "
read input

if [[ $input == n ]]; then
  exit
fi

rm arch-x86_64-uefi-post-chroot.sh
