#
# ~/.bash_profile
#

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"

export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export XDG_CURRENT_SESSION_TYPE=wayland
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ -f ~/.bashrc ]] && . ~/.bashrc
