#!/bin/sh

########################################################################################
#
# Config
#
########################################################################################


#
# Where to log autostarted programs?
#
_MY_LOGPATH="${HOME}/.local/log"

#
# Background Image path
#
_MY_WALLPAPER="${HOME}/Pictures/wallpaper/active-wallpaper"



# Force openoffice.org to use GTK theme
# enable this if you install openoffice
export OOO_FORCE_DESKTOP=gnome
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK


########################################################################################
#
# Wrapper
#
########################################################################################

_log() {
	_lvl="${1}"
	_msg="${2}"
	_log="${_MY_LOGPATH}/log.log"
	_pre="$( date +'%Y-%m-%d  %H:%M:%S' )"

	if [ ! -d "${_MY_LOGPATH}" ]; then
		mkdir -p "${_MY_LOGPATH}"
	fi

	case "${_lvl}" in
		err)
			printf "[%s] [ERROR]:   %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		warn)
			printf "[%s] [WARN]:    %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		info)
			printf "[%s] [INFO]:    %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
		*)
			printf "[%s] [UNKNOWN]: %s\n" "${_pre}" "${_msg}" >> "${_log}"
			;;
	esac
}

#
# Wrapper to start stuff with logging
# and pre-killing functionality
#
# @param string	$1	Full command (including arguments)
# @param string	$2	If not empty: logfile name for logging
#					If empty: Nothing will be logged
# @param string	$3	If not empty: Name of process to kill prior starting
#					if empty: Nothing will be killed
_execute() {
	_cmd="${1}"
	_name="${2}"
	_kill="${3}"

	_log="${_MY_LOGPATH}/log.log"


	if [ ! -d "${_MY_LOGPATH}" ]; then
		mkdir -p "${_MY_LOGPATH}"
	fi

	# Do we need to kill something
	# before starting?
	if [ "${_kill}" != "" ]; then
		_log "info" "Trying to kill ${_kill}"

		if ! _pid="$( pidof "${_kill}" )"; then
			_log "err" "No pid found for ${_kill}"
		else
			if ! kill "${_pid}"; then
				_log "err" "Could not kill pid: ${_pid} for ${_kill}"
			else
				_log "info" "Killed ${_kill} with pid: ${_pid}"
			fi
		fi
	fi

	_log "info" "starting: ${_cmd}"

	# Do we do logging?
	if [ "${_name}" != "" ]; then
		eval "${_cmd} > ${_MY_LOGPATH}/${_name}.log 2> ${_MY_LOGPATH}/${_name}.err &"
	else
		eval "${_cmd} > /dev/null 2>&1 &"
	fi
}



########################################################################################
#
# Exports
#
########################################################################################
_execute "clipmenud" "clipmenud"

## Turn on/off annoying system beep
_execute "xset b off" "xset-b"

## Set keyboard settings - 250 ms delay and 25 cps (characters per second) repeat rate.
## Adjust the values according to your preferances.
# KEYBOARD_RATE=60
# KEYBOARD_DELAY=250
_execute "xset r rate 250 40" "xset-r"

## Turn off monitor
# xset dpms [standby [suspend [off]]]
# Turn off monitor after 5 minutes
_execute "xset dpms 0 0 300" "xset-dpms"

# Auto-lock screen
# xset s sec-notifications sec-lock
_execute "xset s 600 30" "xset-s"
_execute "xss-lock -v -n \"notify-send --urgency=critical --icon=/usr/share/icons/Adwaita/48x48/actions/system-lock-screen.png -- 'Auto-lock in 30 sec.'\" -- /usr/local/bin/xlock" "xss-lock" "xss-lock"

## Network Manager Applet (TASKBAR-ICON)
_execute "nm-applet" "nm-applet" "nm-applet"

## Filemanager Daemon (for auto-mounts
_execute "thunar --daemon" "thunar"

## Wallpaper
_execute "feh --no-fehbg --bg-scale ${_MY_WALLPAPER}" "feh"

## Compositor
_execute "compton" "compton" "compton"

## Notification daemon
_execute "dunst" "dunst" "dunst"

## Bluetooth Manager Applet (TASKBAR-ICON)
#_execute "blueman-applet" "blueman-applet" "blueman-applet"

## Redshift screen
#_execute "redshift-gtk" "redshift-gtk" "redshift"

#_execute "xautolock -detectsleep -time 5 -locker '~/.config/i3/bin/i3exit lock' -notify 15 -notifier \"notify-send -u critical -t 10000 -- 'Locking screen in 15 sec'\"" "xautolock" "xautolock"

## Keyring
#_execute "gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh" "gnome-keyring-daemon" "gnome-keyring-daemon"

## Clipboard (TASKBAR-ICON)
#xfce4-clipman &

## Keyboard Input (TASKBAR-ICON)
#_execute "ibus-daemon --replace --restart --desktop=openbox --xim --daemonize" "ibus-daemon" "ibus-daemon"

#eval "$( dbus-launch --sh-syntax --exit-with-session )"

