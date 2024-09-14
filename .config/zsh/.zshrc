autoload -U colors
autoload -Uz compinit
compinit
_comp_options+=(globdots)
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# History in cache dir
HISTSIZE=30000
SAVEHIST=30000
HISTFILE=~/.cache/zsh/history

bindkey "^?" backward-delete-char
bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Yank to the system clipboard
# function vi-yank-xclip {
#     zle vi-yank
#    echo "$CUTBUFFER" | pbcopy -i
# }

# zle -N vi-yank-xclip
# bindkey -M vicmd 'y' vi-yank-xclip
export KEYTIMEOUT=1

# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
# Replace some more things with better alternatives
# alias cat='bat --style header --style rules --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='/usr/bin/update'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			# List amount of -git packages
alias q="exit"

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# MullvadVPN
alias mullstat="mullvad status --location"
alias md="mullvad disconnect"

# git
alias gs="git status"
alias gv="git status --verbose"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --graph --pretty=format:'%C(auto)%h%d (%cr) %cn %s' --all"
alias ga="git add ."
alias gc="git commit -m $1"
alias gch="git checkout $1"

#  convienience
# alias fuck="sudo $(fc -ln -1)"
alias cls="clear && ls"
alias cl="clear"
l() {
	if [ "$#" -gt 0 ]; then
		lvim $@
	else
		lvim .
	fi
}

# pnpm
alias pd="pnpm run dev"
alias pb="pnpm run build"

k() {
  if [[ $1 == clean || $1 == cl ]]; then
    ~/.config/zsh/scripts/clean_system.sh
  fi
}

st() {
  currentDir=$PWD
  if ! [[ -d ~/code/$1 ]]; then
    echo "(~/code/$1) doesn't exist. Exiting.."
    return
  fi
  cd ~/code/$1
  if [[ -f "./start.sh" ]]; then
    bash start.sh
    cd $currentDir
  else
    lvim .
    cd $currentDir
  fi
}

# Plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# 250 mills of timeout when pressed a button
xset r rate 250

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(thefuck --alias)"
