#!/bin/bash

echo "This will override ~/.config/[ awesome, nvim, starship, zsh, kitty]."
echo -n "Are you sure you want to proceed? [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

if [[ ! -d "./.config" || ! -d "../dotfiles" ]]; then
  echo "Please run the script in the repo directory."
  exit
fi

repodir=$PWD
dotconfig="/home/$USER/.config"

if [[ ! -d $dotconfig ]]; then
  mkdir $dotconfig
fi

cp -r ./.config/zsh $dotconfig
cp -r ./.config/kitty $dotconfig
cp -r ./.config/awesome $dotconfig
cp -r ./.config/starship $dotconfig

cd $dotconfig
if [[ -d "$dotconfig/nvim" ]]; then
  echo -n ".config/nvim exists do you want to pull changes instead? [Y/n] "
  read input

  if [[ $input == "n" ]]; then
    echo "Removing ~/.config/nvim directory..."
    rm -rf nvim
    git clone https://github.com/0ql/LunarVim.git nvim
  else
    cd nvim
    git pull
  fi
else
  git clone https://github.com/0ql/LunarVim.git nvim
fi
cd $repodir

echo -n "Install .xinitrc File? [y/N] "
read input

if [[ $input == "y" ]]; then
  cp .xinitrc /home/$USER/.xinitrc
fi

echo -n "Install .profile .bashrc .bash_profile? [y/N] "
read input

if [[ $input == "y" ]]; then
  cp .profile /home/$USER
  cp .bashrc /home/$USER
  cp .bash_profile /home/$USER
fi

echo -n "(Re)install required software? ArchLinux only (requires pacman) [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

sudo pacman --noconfirm -S kitty zsh awesome starship neovim xorg-xinit xorg-server exa bat zsh-syntax-highlighting zsh-autosuggestions ttf-iosevka-nerd 
