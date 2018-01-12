################################################################################
###
### Custom Aliases
###
################################################################################



###
### xdg-open from terminal (OSX-style)
###
open() {
	nohup xdg-open "${@}" > /dev/null 2>&1
}


###
### google calendar
###
cal() {
	if [ "${#}" = "0" ]; then
		gcalcli calm
	else
		gcalcli "${*}"
	fi
}


###
### www Folder
###
if [ -d "/shared/httpd" ] || [ -L "/shared/httpd" ]; then
	alias www='cd /shared/httpd/'
elif [ -d "${HOME}/Sites" ] || [ -L "${HOME}/Sites" ]; then
	alias www='cd "${HOME}/Sites"'
fi


###
### Go to repo folder
###
repo() {
	local specific="${1:-}"

	if [ "${#}" = "1" ]; then
		cd "${HOME}/repo/"*"${1}"*
	elif [ "${#}" = "2" ]; then
		cd "${HOME}/repo/"*"${1}"*/*"${2}"*
	else
		cd "${HOME}/repo/cytopia"
	fi
}

###
### Go to repo folder
###
workspace() {
	local specific="${1:-}"

	if [ "${specific}" = "" ]; then
		cd "${HOME}/workspace"
	else
		# Go to specific repo
		# $ repo c
		# $ repo f
		cd "${HOME}/workspace/${specific}"*
	fi
}

###
### Open notes
###
notes() {
	local specific="${1:-}"
	local tmp="${HOME}/.cache/notes"

	# Defaults
	local path="${HOME}/notes"
	local name=
	local lock=

	# Create tmp dir
	if [ ! -d "${tmp}" ]; then
		mkdir -p "${tmp}"
	fi

	# Try to get the specific directory
	if [ "${specific}" = "" ]; then
		path="${path}/private"
		name="private"
		lock="${tmp}/${name}.lock"
	else
		for d in ${path}/${specific}*; do
			if [ -d "${d}" ]; then
				path="${d}"
				name="$( basename "${path}" )"
				lock="${tmp}/${name}.lock"
			fi
			# Only try first match
			break;
		done
	fi

	# Check if it is already running
	if [ -f "${lock}" ]; then
		echo "notes (${name}) already running..."
		return 1
	fi

	# Lock
	touch "${lock}"

	cd "${path}"
	if [ "${name}" = "private" ]; then
		${EDITOR:-vim} -o _index.md stash/ablage.md
	else
		${EDITOR:-vim} -o _index.md
	fi

	# Unlock
	rm -f "${lock}"
}

run() {
	if [ ! -d "${HOME}/tmp" ]; then
		mkdir -p "${HOME}/tmp"
	fi

	if [ ! -f "${HOME}/tmp/run.sh" ]; then
		echo "#!/bin/sh"      >  ${HOME}/tmp/run.sh
		echo ""               >> ${HOME}/tmp/run.sh
		echo ""               >> ${HOME}/tmp/run.sh
		echo "echo \"test\""  >> ${HOME}/tmp/run.sh
		echo ""               >> ${HOME}/tmp/run.sh
		echo "exit 0"         >> ${HOME}/tmp/run.sh
	fi

	chmod +x "${HOME}/tmp/run.sh"
	cd "${HOME}/tmp/"
	vim "run.sh"
	./run.sh
}


music() {
	if ! pidof mpd > /dev/null 2>&1; then
		mpd
	fi
	ncmpcpp
}
