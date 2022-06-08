#
# ~/.bash_profile
#

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave-browser-nightly"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/.xinitrc"

export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
export PATH="$PNPM_HOME:$PATH"

export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ -f ~/.bashrc ]] && . ~/.bashrc
