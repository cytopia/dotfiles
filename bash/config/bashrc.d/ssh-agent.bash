SSH_ENV="${HOME}/.ssh/environment"

# Start the ssh-agent
function start_agent {
	local output

	if pidof ssh-agent >/dev/null 2>&1; then
		if [ -f "${SSH_ENV}" ]; then
			. "${SSH_ENV}"
		fi
		return 0
	fi

	echo "Initializing new SSH agent..."
	if ! output="$( ssh-agent -s )"; then
		echo "failed"
		exit 1
	fi
	echo succeeded

	echo "${output}" | sed 's/^echo/#echo/' > "${SSH_ENV}"
	chmod 600 "$SSH_ENV"
	. "${SSH_ENV}" > /dev/null

	load_identities
}

# Load all found ssh keys
function load_identities {
	return
	local priv_keys
	# load all private keys in ~/.ssh
	priv_keys="$( /bin/ls "${HOME}/.ssh/" )"
	echo "Loading SSH identities..."
	for i in ${priv_keys}; do
		if grep -Eq 'BEGIN.*PRIVATE' "${HOME}/.ssh/${i}" 2>/dev/null; then
			echo "${i}"
			ssh-add "${HOME}/.ssh/${i}"
		fi
	done
	echo "Done"
}

# Test for identities
function test_identities {
	# Do we already have identities loaded?
	local ret
	ssh-add -l >/dev/null 2>&1
	ret=$?
	# $?=0 means the socket is there and it has a key
	# $?=1 means the socket is there but contains no key
	# $?=2 means the socket is not there or broken

	if [ "${ret}" = "0" ]; then
		return 0
	elif [ "${ret}" = "1" ]; then
		load_identities
	elif [ "${ret}" = "2" ]; then
		start_agent
	fi
}

function test_agent {
	local pid="${1}"

	# check if non-empty
	if [ -n "${pid}" ]; then
		ps -ef | grep 'ssh-agent' | awk '{print $2}' | grep -q "${pid}";
	else
		return 1
	fi
}


###
### ssh-agent env variables set
###
if [ ! -z "${SSH_AGENT_PID+x}" ]; then

	# check if ssh-agent is running by this pid
	if test_agent "${SSH_AGENT_PID}"; then
		# all good, check if keys were loaded already
		test_identities
	else
		# not running, start ssh-agent
		start_agent
	fi
###
### if $SSH_AGENT_PID is not properly set, we might be able to load one from $SSH_ENV
###
else
	if [ -f "${SSH_ENV}" ]; then
		. "${SSH_ENV}" > /dev/null
	fi

	# Is $SSH_AGENT_PID set now?
	if [ ! -z "${SSH_AGENT_PID+x}" ]; then
		# check if ssh-agent is running by this pid
		if test_agent "${SSH_AGENT_PID}"; then
			test_identities
		else
			start_agent
		fi
	else
		start_agent
	fi
fi
