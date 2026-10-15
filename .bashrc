#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

hypr() {
	cd ~

	exec start-hyprland
}
export PATH="$PATH:/home/kaffee/.cargo/bin"
