#
# ~/.bash_profile
#

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_CURRENT_SESSION_TYPE=wayland
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/.xinitrc"
export GTK_THEME=gruvbox-dark-gtk

export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24
export LIBVA_DRIVER_NAME=nvidia
export CLUTTER_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export WLR_BACKEND=vulkan
export QT_QPA_PLATFORM="wayland;xcb"
export GDK_BACKEND=wayland

export WLR_RENDERER=vulkan
export __GL_GSYNC_ALLOWED=0
export __GL_VRR_ALLOWED=0

export ANDROID_HOME=~/Android/Sdk
export LIBSEAT_BACKEND=logind

[[ -f ~/.bashrc ]] && . ~/.bashrc
