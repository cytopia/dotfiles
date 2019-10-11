################################################################################
###
### Colors
###
################################################################################


#	Color		Foreground	Background
#	Black			30			40
#	Red				31			41
#	Green			32			42
#	Yellow			33			43
#	Blue			34			44
#	Magenta			35			45
#	Cyan			36			46
#	White			37			47



################################################################################
###
### ls colors
###
################################################################################

# On FreeBSD and Mac OS X, ls shows colors if the CLICOLOR
# environment variable is set or if -G is passed on the command line.
# The actual colors are configured through the LSCOLORS environment variable

# With GNU ls, e.g. on Linux, ls shows colors if --color is passed
# on the command line. The actual colors are configured through the
# LS_COLORS environment variable, which can be set with the dircolors
# command (built-in defaults are used if this variable is not set).

###
### Enable 'ls' colors
###
export CLICOLOR=1



################################################################################
###
### grep colors
###
################################################################################

###
### colored grep results
###
export GREP_COLORS='0;31'



################################################################################
###
### mutt colors
###
################################################################################

###
### mutt background fixes
###
export COLORFGBG="default;default"



################################################################################
###
### man page colors
###
################################################################################

###
### Enable color when reading man-pages
###
export LESS_TERMCAP_mb=$'\E[01;31m'		# begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'		# begin bold
export LESS_TERMCAP_me=$'\E[0m'			# end mode
export LESS_TERMCAP_se=$'\E[0m'			# end standout-mode
export LESS_TERMCAP_so=$'\E[01;44;33m'	# begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'			# end underline
export LESS_TERMCAP_us=$'\E[01;32m'		# begin underline
