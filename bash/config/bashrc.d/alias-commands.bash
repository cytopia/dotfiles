################################################################################
###
### Command Aliases
###
################################################################################



###
### Defaults
###
alias df='df -h'					# human readable, print filetype
alias du='du -d1 -h'				# max depth, human readable
alias info='info --vi-keys'			# GNU info act like man command
alias less='less --IGNORE-CASE --tabs=4 --status-column --LONG-PROMPT --line-numbers --RAW-CONTROL-CHARS'
alias mkdir='mkdir -p -v'			# create if not exist, verbose
alias mount='mount | column -t'		# align in column
alias wget='wget -c'				# continues/resumes
alias ssh="env TERM=xterm-256color ssh"
alias su='su -l'
alias suc='su'
alias tmux="tmux -2 -u"
alias ta="tmux -2 -u attach"

#alias vi='env TERM=xterm-256color vim'
#alias vim='env TERM=xterm-256color vim'
alias vi='nvim'
alias vim='nvim'

alias  grep=' grep --color=auto --binary-file=without-match'
alias fgrep='fgrep --color=auto --binary-file=without-match'
alias egrep='egrep --color=auto --binary-file=without-match'
alias rgrep='rgrep --color=auto --binary-file=without-match'



###
### Safeguard
###
alias cp='cp -i'
alias ln='ln -i'
alias mv='mv -i'
alias rm='rm -i'


###
### Shorthands
###
alias a='alias'
alias h="history"
alias j="jobs -l"
if command -v ranger >/dev/null 2>&1; then
	alias r="ranger"
fi


###
### Geek aliase
###
alias fuck='sudo $(history -p \!\!)' # Redo last command as root
alias fake="cat /dev/urandom | hexdump -C | grep 'ca fe'"



###
### Directory traversal
###
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."



###
### ls defaults
###
if command -v gls >/dev/null 2>&1; then # Gnu ls (gls via: brew install coreutils)

	alias  l='gls --color=always --group-directories-first --classify -l'
	alias ll='gls --color=always --group-directories-first --classify -al'
	alias ls='gls --color=always --group-directories-first --classify'
	alias la='gls --color=always --group-directories-first --classify -a'

	alias  l.='gls --color=always --group-directories-first --classify -l -d .*'
	alias la.='gls --color=always --group-directories-first --classify -d .*'

	# sort by time
	alias  lt='gls --color=always --classify -lt'
	alias llt='gls --color=always --classify -alt'
	alias lst='gls --color=always --classify -t'
	alias lat='gls --color=always --classify -at'

	alias  lt.='gls --color=always --classify -lt -d .*'
	alias lat.='gls --color=always --classify -t -d .*'

	alias lsg='gls --color=always --group-directories-first --classify -al | grep'

elif [ "$(uname)" == "Linux" ]; then # Gnu ls (Linux)

	alias  l='LC_ALL=C ls --color=always --group-directories-first --classify -l'
	alias ll='LC_ALL=C ls --color=always --group-directories-first --classify -al'
	#alias  l='lsl.py --color=always --group-directories-first -l'
	#alias ll='lsl.py --color=always --group-directories-first -al'
	alias ls='LC_ALL=C ls --color=always --group-directories-first --classify'
	alias la='LC_ALL=C ls --color=always --group-directories-first --classify -a'

	alias  l.='LC_ALL=C ls --color=always --group-directories-first --classify -l -d .*'
	alias la.='LC_ALL=C ls --color=always --group-directories-first --classify -d .*'

	# sort by time
	alias  lt='LC_ALL=C ls --color=always --classify -lt'
	alias llt='LC_ALL=C ls --color=always --classify -alt'
	alias lst='LC_ALL=C ls --color=always --classify -t'
	alias lat='LC_ALL=C ls --color=always --classify -at'

	alias  lt.='LC_ALL=C ls --color=always --classify -lt -d .*'
	alias lat.='LC_ALL=C ls --color=always --classify -t -d .*'

	alias llg='LC_ALL=C ls --color=always --group-directories-first --classify -al | grep'

else # Posix ls (OSX/FreeBSD)

	alias  l='ls -oFl'
	alias ll='ls -oFal'
	alias ls='ls -F'
	alias la='ls -Fa'

	alias  l.='ls -oFl -d .*'
	alias la.='ls -F -d .*'

	# sort by time
	alias  lt='ls -olFt'
	alias lat='ls -aFt'
	alias llt='ls -laFt'
	alias lst='ls -Ft'

	alias  lt.='ls -oFlt -d .*'
	alias lat.='ls -Ft -d .*'

	alias llg='ls -oFal | grep'
fi
