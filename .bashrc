#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# pnpm
export PNPM_HOME="$USER/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
