#!/bin/sh

# Ask a yes/no question and read users choise
#
# @param        string  Question to ask
# @param        string  Default 'Y' or 'N' (or 'F' for not asking and assuming yes)
# @return       int             0: yes | 1:no
ask() {
	question=$1

	if [ "${2:-}" = "Y" ]; then
		prompt="$(tput setaf 3)Y$(tput sgr0)/$(tput setaf 3)n$(tput sgr0)"
		default=Y
	elif [ "${2:-}" = "N" ]; then
		prompt="$(tput setaf 3)y$(tput sgr0)/$(tput setaf 3)N$(tput sgr0)"
		default=N
	# Force Yes without asking
	elif [ "${2:-}" = "F" ]; then
		return 0
	else
		prompt="$(tput setaf 3)y$(tput sgr0)/$(tput setaf 3)n$(tput sgr0)"
		default=
	fi

	while true; do


		# /dev/tty for redirection
		read -p "$(tput setaf 2)${question} $(tput sgr0)(${prompt})" yn </dev/tty

		# Default?
		if [ -z "$yn" ]; then
			yn=$default
		fi

		case $yn in
			[Yy]* ) return 0 ;;
			[Nn]* ) return 1 ;;
			* )		echo "Please answer (y)es or (n)o.";;
		esac

	done
}



# Bind a file (Symlink or copy)
#
# @param		string	From file
# @param		string	To file
# @param		string	Type: "ln" or "cp"
# @param		string	Backup directory
# @return		int		0:success | 1:failure
_bind_file() {

	from="${1}"
	to="${2}"
	bind_type="${3}"
	backup="${4}"
	_sudo="${5}"

	# If the source file does not exist, do nothing!!
	if [ ! -f "${from}" ] && [ ! -d "${from}" ] ; then

		echo "$(tput setaf 1)${from}$(tput sgr0) does not exist."
		return 1

	else

		# 1) create backup folder if necessary
		if [ ! -d "${backup}" ]; then
			echo "Creating Backup dir: ${backup}"
			mkdir "${backup}"
		fi



		# 2) Check if the new target file already exists
		#    either as a directory (-d)
		#    or an ordinary file (-f)
		#    or as a symlink (-h)
		if [ -f "${to}" ] || [ -h "${to}" ] || [ -d "${to}" ]; then

			# As the target file already exists, we either want it
			# to be copied to the backup folder (if there is no backup yet)
			# or delete it without backuping (if there is already a backup)

			# If file/folder/symlink already in
			# backup dir, do not overwrite it,
			# just delete the original one and leave
			# the backup alone
			basename=$(basename "${to}")
			if [ -f "${backup}/${basename}" ] || [ -h "${backup}/${basename}" ] || [ -d "${backup}/${basename}" ]; then
				if [ "${_sudo}" = "sudo" ]; then
					sudo rm -rf "${to}"
				else
					rm -rf "${to}"
				fi

			# Otherwise move the original one to the
			# backup dor
			else
				# follow symlinks and copy target instead
				# of symlink itself
				cp -R "${to}" "${backup}"
				if [ "${_sudo}" = "sudo" ]; then
					sudo rm -rf "${to}"
				else
					rm -rf "${to}"
				fi
			fi

		fi

		# 3) Check if parent directory actually exists
		#    and if not create it first prior symlinking
		#    Otherwise symlinking will not work
		parent=$(dirname "${to}")
		if [ ! -d "${parent}" ]; then
			if [ "${_sudo}" = "sudo" ]; then
				sudo mkdir -p "${parent}"
			else
				mkdir -p "${parent}"
			fi
		fi

		# 4) Symlink/Copy the sucker
		if [ "${_sudo}" = "sudo" ]; then
			if [ "${bind_type}" = "ln" ]; then
				sudo ln -s "${from}" "${to}"
			elif [ "${bind_type}" = "cp" ]; then
				sudo cp -r "${from}" "${to}"
			fi
		else
			if [ "${bind_type}" = "ln" ]; then
				ln -s "${from}" "${to}"
			elif [ "${bind_type}" = "cp" ]; then
				cp -r "${from}" "${to}"
			fi
		fi

		return 0
	fi
}


symlink_file() {
	from="${1}"
	to="${2}"
	backup="${3}"
	if [ "${#}" = "4" ] && [ "${4}" = "sudo" ]; then
		echo "sudo [ln] --> ${to}"
		_bind_file "${from}" "${to}" "ln" "${backup}" "sudo"
	else
		echo "     [ln] --> ${to}"
		_bind_file "${from}" "${to}" "ln" "${backup}" ""
	fi
}

copy_file() {
	from="${1}"
	to="${2}"
	backup="${3}"
	if [ "${#}" = "4" ] && [ "${4}" = "sudo" ]; then
		echo "sudo [cp] --> ${to}"
		_bind_file "${from}" "${to}" "cp" "${backup}" "sudo"
	else
		_bind_file "${from}" "${to}" "cp" "${backup}" "s"
		echo "     [cp] --> ${to}"
	fi
}

