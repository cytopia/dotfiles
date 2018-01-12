################################################################################
###
### System configuration
###
################################################################################

###
### /etc/fstab
###
cfg-fstab() {
	if [ "$(id -u)" == "0" ]; then
		${EDITOR:-vim} /etc/fstab
	else
		sudo "${EDITOR:-vim}" /etc/fstab;
	fi
}


###
### /etc/hosts
###
cfg-hosts() {
	if [ "$(id -u)" == "0" ]; then
		${EDITOR:-vim} /etc/hosts
	else
		sudo "${EDITOR:-vim}" /etc/hosts
	fi
}

cfg-xdg-dirs() {
	if [ -f ${XDG_CONFIG_HOME}/user-dirs.dirs ]; then
		${EDITOR:-vim} ${XDG_CONFIG_HOME}/user-dirs.dirs
	fi
}

################################################################################
###
### Bash configuration
###
################################################################################

###
### ~/.bashrc
###
if [ -f "${HOME}/.bashrc" ]; then
	cfg-bashrc()			{ ${EDITOR:-vim} ~/.bashrc; };
fi


###
### ~/.bash_profile
###
if [ -f "${HOME}/.bash_profile" ]; then
	cfg-bash-profile()			{ ${EDITOR:-vim} ~/.bash_profile; };
fi


###
### ~/.config/bash/bashrc.d/*.bash
###
if [ -d "${XDG_CONFIG_HOME}/bash/bashrc.d/" ]; then
	for _f in ${XDG_CONFIG_HOME}/bash/bashrc.d/*.bash ; do
		_suffix="$( basename "${_f}" )"
		_suffix="${_suffix%.bash}"
		eval "cfg-bash-${_suffix}() { ${EDITOR:-vim} \"${_f}\"; }"
		unset _f
		unset _suffix
	done
fi


###
### ~/.config/bash/bash_profile/*.bash
###
if [ -d "${XDG_CONFIG_HOME}/bash/bash_profile/" ]; then
	for _f in ${XDG_CONFIG_HOME}/bash/bash_profile/*.bash ; do
		_suffix="$( basename "${_f}" )"
		_suffix="${_suffix%.bash}"
		eval "cfg-bash-${_suffix}() { ${EDITOR:-vim} \"${_f}\"; }"
		unset _f
		unset _suffix
	done
fi



################################################################################
###
### Ranger configuration
###
################################################################################

if [ -f "${HOME}/.config/ranger/rc,conf" ]; then
	cfg-ranger()			{ ${EDITOR:-vim} ~/.config/ranger/rc.conf; }
fi
if [ -f "${HOME}/.config/ranger/rifle,conf" ]; then
	cfg-ranger-rifle()		{ ${EDITOR:-vim} ~/.config/ranger/rifle.conf; } # edit open_with extensions
fi
if [ -f "${HOME}/.config/ranger/commands,py" ]; then
	cfg-ranger-commands()	{ ${EDITOR:-vim} ~/.config/ranger/commands.py; } # scripts
fi



################################################################################
###
### Misc configuration
###
################################################################################

###
### Single dotfiles
###
if [ -f "${HOME}/.inputrc" ]; then
	cfg-inputrc()			{ ${EDITOR:-vim} ~/.inputrc; };
fi
if [ -f "${HOME}/.gitconfig" ]; then
	cfg-git()				{ ${EDITOR:-vim} ~/.gitconfig; };
fi
if [ -f "${HOME}/.ctags" ]; then
	cfg-ctags()				{ ${EDITOR:-vim} ~/.ctags; };
fi
if [ -f "${HOME}/.muttrc" ]; then
	cfg-mutt()				{ ${EDITOR:-vim} ~/.muttrc; };
fi
if [ -f "${HOME}/.tmux.conf" ]; then
	cfg-tmux()				{ ${EDITOR:-vim} ~/.tmux.conf; };
fi
if [ -f "${HOME}/.vimrc" ]; then
	cfg-vim()				{ ${EDITOR:-vim} ~/.vimrc; };
fi
if [ -f "${HOME}/.config/nvim/vim.init" ]; then
	cfg-nvim()				{ ${EDITOR:-vim} ~/.config/nvim/vim.init; };
fi
if [ -f "${HOME}/.Xdefaults" ]; then
	cfg-xdefaults()			{ ${EDITOR:-vim} ~/.Xdefaults; };
fi
if [ -f "${HOME}/.xinitrc" ]; then
	cfg-xinitrc()			{ ${EDITOR:-vim} ~/.xinitrc; };
fi
if [ -f "${HOME}/.Xmodmap" ]; then
	cfg-xmodmap()			{ ${EDITOR:-vim} ~/.Xmodmap; };
fi
if [ -f "${HOME}/.Xresources" ]; then
	cfg-xresources()		{ ${EDITOR:-vim} ~/.Xresources; };
fi
if [ -f "${HOME}/.xsession" ]; then
	cfg-xsession()			{ ${EDITOR:-vim} ~/.xsession; };
fi


###
### ~/.config/Xresources.d/*.xresources
###
if [ -d "${XDG_CONFIG_HOME}/Xresources.d/" ]; then
	for _f in ${XDG_CONFIG_HOME}/Xresources.d/*.xresources ; do
		_suffix="$( basename "${_f}" )"
		_suffix="${_suffix%.xresources}"
		eval "cfg-xresources-${_suffix}() { ${EDITOR:-vim} \"${_f}\"; }"
		unset _f
		unset _suffix
	done
fi
