################################################################################
###
### Reload configuration
###
################################################################################


###
### Update locate database
###
rld-updatedb() {
	echo "\$ sudo /usr/libexec/locate.updatedb"
	sudo /usr/libexec/locate.updatedb
}


###
### Reload bash config
###
if [ -f ~/.bash_profile ]; then
	rld-bash() {
		echo "\$ source ~/.bash_profile"
		# shellcheck disable=SC1090
		source ~/.bash_profile
	}
fi


###
### Reload xdg-dirs
###
if [ -f ${XDG_CONFIG_HOME}/user-dirs.dirs ]; then
	rld-xdg-dirs() {
		echo "\$ xdg-user-dirs-update"
		xdg-user-dirs-update
	}
fi


###
### Reload Xdefaults config
###
if [ -f ~/.Xdefaults ]; then
	rld-xdefaults() {
		echo "\$ xrdb -load ~/.Xdefaults"
		xrdb -load ~/.Xdefaults
	}
fi


###
### Reload Xmodmap config
###
if [ -f ~/.Xmodmap ]; then
	rld-xmodmap() {
		echo "\$ xmodmap ~/.Xmodmap"
		xmodmap ~/.Xmodmap
	}
fi


###
### Reload Xresources config
###
if [ -f ~/.Xresources ]; then
	rld-xresources() {
		echo "\$ xrdb ~/.Xresources"
		xrdb ~/.Xresources
	}
fi


###
### Reload gpg agent
###
rld-gpg-agent() {
	echo "\$ gpg-connect-agent reloadagent /bye"
	gpg-connect-agent reloadagent /bye
}
