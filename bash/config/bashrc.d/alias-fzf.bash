################################################################################
###
### FZF Aliases
###
################################################################################


###
### locate
###
f() {
	local file
	dir="$(pwd)"
	file=$(locate "${dir}/" 2>/dev/null | fzf +m) && if [ -d "$file" ]; then cd "$file"; else ${EDITOR:-vim} "$file"; fi
}


###
### Edit file
###
fe() {
	local file

	file="$( find . \
		-type f \
		-not \( \
			-path "*/.git*" -o \
			-path "*/.svn*" -o \
			-path "*.png" -o \
			-path "*.jpg" -o \
			-path "*.jpeg" -o \
			-path "*.bin" -o \
			-path "*.svg" -o \
			-path "*.gz" -o \
			-path "*.tar" -o \
			-path "*.tgz" -o \
			-path "*.zip" \
		\) \
		! -size 0 \
		-print 2> /dev/null | fzf +m)" &&
	${EDITOR:-vim} "$file"
}
#fe() {
#	local file
#	local cpu
#
#	cpu="$(getconf _NPROCESSORS_ONLN)"
#
#	file="$( find . \
#		-type f \
#		-not \( -path "*/.git*" -o -path "*/.svn*" \) \
#		! -size 0 \
#		-print0 2> /dev/null | \
#		xargs -0 -P ${cpu} -n1 grep -Il '' 2>/dev/null | \
#		fzf +m)" &&
#	${EDITOR:-vim} "$file"
#}




###
### Goto directory
###
fd() {
	local dir
	dir=$(find . \
		-not \( -path "*/.*" -prune \) \
			-not \( -path "*/Library/*" -prune \) \
			-not \( -path "*/Applications/*" -prune \) \
			-not \( -ipath "*/cache/*" -prune \) \
		-type d -print 2> /dev/null | fzf +m) &&
	cd "$dir"
}


###
### kill process
###
fkill() {
	ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9}
}


###
### Show process
###
fps() {
	ps aux | sed 1d | fzf -m
}


###
### History search
###
fh() {
	eval "$(history | fzf +s --tac |  cut -d' ' -f 7- )"
}

