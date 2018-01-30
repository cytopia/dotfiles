################################################################################
###
### PS1 prompt
###
################################################################################

D=$'\e[37;40m'
#PINK=$'\e[35;40m'
#PINK=$'\e[35;35m'
GREEN=$'\e[32;40m'
ORANGE=$'\e[33;40m'



# Reset
Color_Off='\e[0m'		# Text Reset

# Regular Colors
Black=$'\e[0;30m'		# Black
Red=$'\e[0;31m'			# Red
Green=$'\e[0;32m'		# Green
Yellow=$'\e[0;33m'		# Yellow
Blue=$'\e[0;34m'			# Blue
Purple=$'\e[0;35m'		# Purple
Cyan=$'\e[0;36m'			# Cyan
White=$'\e[0;37m'		# White
# Bold
BBlack='\e[1;30m'		# Black
BRed='\e[1;31m'			# Red
BGreen='\e[1;32m'		# Green
BYellow='\e[1;33m'		# Yellow
BBlue='\e[1;34m'		# Blue
BPurple='\e[1;35m'		# Purple
BCyan='\e[1;36m'		# Cyan
BWhite='\e[1;37m'		# White
# Underline
UBlack='\e[4;30m'		# Black
URed='\e[4;31m'			# Red
UGreen='\e[4;32m'		# Green
UYellow='\e[4;33m'		# Yellow
UBlue='\e[4;34m'		# Blue
UPurple='\e[4;35m'		# Purple
UCyan='\e[4;36m'		# Cyan
UWhite='\e[4;37m'		# White
# Background
On_Black='\e[40m'		# Black
On_Red='\e[41m'			# Red
On_Green='\e[42m'		# Green
On_Yellow='\e[43m'		# Yellow
On_Blue='\e[44m'		# Blue
On_Purple='\e[45m'		# Purple
On_Cyan='\e[46m'		# Cyan
On_White='\e[47m'		# White
# High Intensity
IBlack='\e[0;90m'		# Black
IRed='\e[0;91m'			# Red
IGreen='\e[0;92m'		# Green
IYellow='\e[0;93m'		# Yellow
IBlue='\e[0;94m'		# Blue
IPurple='\e[0;95m'		# Purple
ICyan='\e[0;96m'		# Cyan
IWhite='\e[0;97m'		# White
# Bold High Intensity
BIBlack='\e[1;90m'		# Black
BIRed='\e[1;91m'		# Red
BIGreen='\e[1;92m'		# Green
BIYellow='\e[1;93m'		# Yellow
BIBlue='\e[1;94m'		# Blue
BIPurple='\e[1;95m'		# Purple
BICyan='\e[1;96m'		# Cyan
BIWhite='\e[1;97m'		# White
# High Intensity backgrounds
On_IBlack='\e[0;100m'	# Black
On_IRed='\e[0;101m'		# Red
On_IGreen='\e[0;102m'	# Green
On_IYellow='\e[0;103m'	# Yellow
On_IBlue='\e[0;104m'	# Blue
On_IPurple='\e[0;105m'	# Purple
On_ICyan='\e[0;106m'	# Cyan
On_IWhite='\e[0;107m'	# White






##############################################################################################
#
# BASH PS1
#
##############################################################################################

# Success of previous command
PS1_SUCCESS="\$(ret=\$?; if [ \$ret = 0  ]; then echo \[\e[32m\][0]\[\e[0m\]; else echo \[\e[31m\][\$ret]\[\e[0m\]; fi)"






_get_git_dirty() {
	readonly GIT_BRANCH_CHANGED_SYMBOL='+'
	readonly GIT_NEED_PUSH_SYMBOL='⇡'
	readonly GIT_NEED_PULL_SYMBOL='⇣'
	local marks

	local tmp="$( git status --porcelain --branch 2> /dev/null )"
	if [ "${?}" != "0" ]; then
		return 1
	fi

	local stat="$( echo "${tmp}" | grep '^##' | grep -o '\[.\+\]$')"

	[[ $( echo "${tmp}" | wc -l) -gt 1 ]] && marks+="${GIT_BRANCH_CHANGED_SYMBOL}"

	# how many commits local branch is ahead/behind of remote?
	local stat="$( echo "${tmp}" | grep '^##' | grep -o '\[.\+\]$')"
	local aheadN="$(echo $stat | grep -o 'ahead[[:space:]][0-9]+' | grep -o '[0-9]\+' )"
	local behindN="$(echo $stat | grep -o 'behind[[:space:]][0-9]\+' | grep -o '[0-9]\+' )"
	[ -n "$aheadN" ] && marks+=" ${GIT_NEED_PUSH_SYMBOL}${aheadN}"
	[ -n "$behindN" ] && marks+=" ${GIT_NEED_PULL_SYMBOL}${behindN}"

	echo "${marks}"
}

_get_git_branch() {
	readonly GIT_BRANCH_SYMBOL=""
	local git_branch

	if ! git_branch="$( git branch --no-color 2> /dev/null | grep '^*[[:space:]]' )"; then
		return 1
	fi

	git_branch="$( echo "${git_branch}" | sed 's/^\*[[:space:]]*//g' )"
	echo "${GIT_BRANCH_SYMBOL}${git_branch}"
}


_get_git_remote() {
	readonly GIT_REMOTE_SYMBOL="☿"
	local git_remote

	if ! git_remote="$( git remote -v 2> /dev/null )"; then
		return 1
	fi

	# has remote?
	if ! git_remote="$( echo "${git_remote}" | grep '(fetch)' )"; then
		echo "[no remote]"
		return
	fi

	git_remote="$( echo "${git_remote% (fetch)}" )"
	if [ "${#git_remote}" = "0" ]; then
		return
	fi
	git_remote="$( basename "${git_remote}" )"
	echo "${GIT_REMOTE_SYMBOL} ${git_remote}"
}


get_git_prompt() {
	local git_dirty
	local git_branch
	local git_remote

	if ! git_dirty="$( _get_git_dirty )"; then
		return
	fi
	if ! git_branch="$( _get_git_branch )"; then
		return
	fi
	if ! git_remote="$( _get_git_remote )"; then
		return
	fi

	echo "(${git_remote} ${git_branch}${git_dirty})"
}



parse_svn() {
	# Helpers
	local svn_info
	local svn_root
	local svn_url

	# Final output
	local branch
	local repository
	svn_info=$(svn info 2>/dev/null)

	if [ ${#svn_info} -gt 0 ]; then
		svn_root=$(echo "$svn_info" | sed -ne 's#^Repository Root: ##p')
		svn_url=$(echo "$svn_info" | sed -ne 's#^URL: ##p')

		repository=$(echo "$svn_info" | grep "^Repository Root" | awk '{print $3}')
		repository=$(basename $repository)

		branch=$(echo "$svn_url" | sed -e 's#^'"$svn_root"'##g')
		branch=$(echo "$branch" | cut -d "/" -f2)

		if [ ${#branch} -eq 0 ]; then
			branch="/"
		fi

		echo " (svn::${repository}::${branch})"
	fi
}
# Append Git status?
PS1_GIT="\[$BRed\] \$(get_git_prompt)\[$Color_Off\]"


# Append SVN status?
if command -v svn >/dev/null 2>&1 ; then
	PS1_SVN="\[$BRed\]\$(parse_svn)\[$Color_Off\]"
else
	PS1_SVN=""
fi



# Inside FreeBSD Jail
if [ -d /boot/kernel ] && [ $(ls -l /boot/kernel/ | grep -v total | wc -l) == "0" ]; then
	PS1_JAIL="[\[$Green\]JAIL\[$Color_Off\]]"
else
	PS1_JAIL="\[$Color_Off\]"
fi


# User Color
if [ "$USER" = "root" ]; then
	PS1_USER="\[$Red\]\u\[$Color_Off\]"
	PS1_CHAR="\[$Red\]#\[$Color_Off\]"
else
	PS1_USER="\[$Blue\]\u\[$Color_Off\]"
	PS1_CHAR="\[$Blue\]\$\[$Color_Off\]"
fi

PS1_HIST="[\#]"
PS1_HOST="\[$Cyan\]\H"
PS1_PATH="\[$Green\]\$PWD\[$Color_Off\]"
PS1_GO="\[$Color_Off\]C:\\>\[$Color_Off\]"
#PS1_GO="\[$Color_Off\]☿ \[$Color_Off\]"
#PS1_GO="\[$Color_Off\]\[$Color_Off\]"

#export PS1="${PS1_JAIL}[${PS1_USER}@${PS1_HOST}:${PS1_PATH}${PS1_GIT}]$PS1_CHAR\n$PS1_GO"


pid="$$"
lvl="$( pstree -s -p ${pid} | sed 's/[()0-9]//g' | awk -F "---" '{for (i=2; i<NF; i++) print $i}' )"
post=
for l in $lvl; do
	post="${post}${l}>"
done
if [ "${post}" = "tmux>bash>" ]; then
	PS1_GO="tmux:\\>"
else
	PS1_GO="${post/#sh>urxvt>/}"
fi

export PS1="${PS1_SUCCESS}\n${PS1_HIST} ${Purple}\u ${Color_Off}at ${Yellow}\h ${Color_Off}in ${Green}\w${PS1_GIT}${PS1_SVN}${Color_Off}\n${PS1_GO} "

