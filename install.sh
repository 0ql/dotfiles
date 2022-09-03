#!/usr/bin/env bash

if [[ ! $1 == -u ]]; then
  echo "[Install] This will override ~/.config/[ awesome, nvim, starship, zsh, kitty, hypr ]."
  echo -n "[Install] Are you sure you want to proceed? [y/N] "
  read input

  if [[ $input != "y" ]]; then
    exit
  fi
else
  echo "[Install] Updateing..."
fi

if [[ ! -d "./.config" || ! -d "../dotfiles" ]]; then
  echo "[Install] Please run the script in the repo directory. Exiting..."
  exit
fi

repodir=$PWD
dotconfig=/home/$USER/.config
dotcache=/home/$USER/.cache

if [[ ! -d $dotconfig ]]; then
  mkdir $dotconfig
fi
if [[ ! -d $dotcache ]]; then
  mkdir $dotcache
fi
if [[ ! -d $dotcache/zsh ]]; then
  mkdir $dotcache/zsh
fi
if [[ ! -f $dotcache/zsh/history ]]; then
  touch $dotcache/zsh/history
fi

cp -rp ./.config/zsh $dotconfig
cp -r ./.config/kitty $dotconfig
cp -r ./.config/awesome $dotconfig
cp -r ./.config/starship $dotconfig
cp -rp ./.config/hypr $dotconfig

echo "[Install] Adding ($PWD) to .zshrc"
echo "[Install|Info] Make sure to run this script if you move the dotfiles DIR."
echo "
dot() {
  currentDir=\$PWD
  cd $PWD
  nvim .
  cd \$currentDir
} 
up() {
  currentDir=\$PWD
  cd $PWD
  bash install.sh -u -n
  cd \$currentDir
}
" >> $dotconfig/zsh/.zshrc

cd $dotconfig
if [[ -d "$dotconfig/nvim" ]]; then
  if [[ ! $1 == -u ]]; then
    echo -n "[Install] ($dotconfig/nvim) exists do you want to pull changes instead? [Y/n] "
    read input
  fi

  if [[ $input == "n" ]]; then
    echo "[Install] Removing ~/.config/nvim directory..."
    rm -rf nvim
    git clone https://github.com/0ql/LunarVim.git nvim
    cd nvim
    echo | make
  else
    cd nvim
    echo -n "[Neovim|Git] "
    git pull
  fi
else
  git clone https://github.com/0ql/LunarVim.git nvim
  cd nvim
  echo | make
fi
cd $repodir

if [[ $2 == -n || $1 == -n ]]; then
  exit
fi

echo -n "[Install] .bashrc .bash_profile? [y/N] "
read input

if [[ $input == "y" ]]; then
  cp .bashrc /home/$USER
  cp .bash_profile /home/$USER
fi

echo -n "[Install] (Re)install required software and add chaotic-aur? ArchLinux only (requires pacman) [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key FBA220DFC880C036
pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf

sudo pacman --noconfirm -S yay

# TODO: select hyprpaper monitor
yay pacman --noconfirm -S kitty zsh starship neovim exa bat zsh-syntax-highlighting zsh-autosuggestions nerd-fonts-fira-code ripgrep hyprland-bin hyprpaper-git wofi gruvbox-dark-gtk

echo -n "[Install] (Re)install not required software? ArchLinux only (requires pacman) [y/N] "
read input

if [[ $input != "y" ]]; then
  exit
fi

sudo pacman --noconfirm -S yay-bin brave-bin lxappearance virt-manager unzip unrar
