#!/bin/bash

echo "This will override ~/.config/[ awesome, nvim, starship, zsh, kitty]."
echo -n "Are you sure you want to proceed? [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

dotconfig="/home/$USER/.config"

if [[ ! -d $dotconfig ]]; then
  mkdir $dotconfig
fi

if [[ ! -d "./.config" || ! -d "../dotfiles" ]]; then
  echo "Please run the script in the repo directory."
  exit
fi

cp ./.config/zsh $dotconfig
cp ./.config/kitty $dotconfig
cp ./.config/awesome $dotconfig
cp ./.config/starship $dotconfig

cd $dotconfig
git clone https://github.com/0ql/LunarVim.git nvim

echo -n "Install .xinitrc File? [y/N] "

if [[ $input == "y" ]]; then
  cp ./.xinitrc /home/$USER/.xinitrc
fi

echo -n "Install .profile .bashrc .bash_profile? [y/N]"

if [[ $input == "y" ]]; then
  cp ./.profile /home/$USER
  cp ./.bashrc /home/$USER
  cp ./.bash_profile /home/$USER
fi

echo -n "(Re)install required software? ArchLinux only (requires pacman) [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

sudo pacman --noconfirm -S kitty zsh awesome starship neovim xorg-xinit xorg-server
