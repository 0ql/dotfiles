#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

hypr() {
	cd ~

	exec Hyprland
}

xfceee() {
	cd ~

	exec startxfce4
}
