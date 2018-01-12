################################################################################
###
### CTAGs configuration
###
################################################################################



###
### cscope
###
#make-cscope() {
#	find . \
#		-type d '(' -name .svn -o -name .git ')' -prune -o \
#		-type f '(' -name tags ')' -prune -o \
#		-type f -print > cscope.files
#
#	# -b: just build
#	# -q: create inverted index
#	cscope -b -q
#}



###
### ctags (general)
###
make-ctags() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -RBF -f .tags \
		--file-scope=yes \
		--sort=yes \
		--extra=+fq \
		2>/dev/null
}

###
### ctags (for CSS)
###
make-ctags-css() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/css \
		--file-scope=yes \
		--sort=yes \
		--languages=css \
		2>/dev/null
}

###
### ctags (for JavaScript)
###
make-ctags-js() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/js \
		--file-scope=yes \
		--sort=yes \
		--languages=JavaScript \
		2>/dev/null
}

###
### ctags (for HTML)
###
make-ctags-html() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/html \
		--file-scope=yes \
		--sort=yes \
		--languages=HTML \
		2>/dev/null
}

###
### ctags (for Markdown)
###
make-ctags-md() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/md \
		--file-scope=yes \
		--sort=yes \
		--langdef=markdown \
		--langmap=markdown:.md \
		--regex-markdown="/^#[ \t](.*$)/\1/h,heading,headings/" \
		2>/dev/null
}

###
### ctags (for PHP)
###
make-ctags-php() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/php \
		--file-scope=yes \
		--sort=yes \
		--fields=+afikKlmnsSzt \
		--languages=PHP \
		--extra=+fq \
		2>/dev/null
}

###
### ctags (for SQL)
###
make-ctags-sql() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/sql \
		--file-scope=yes \
		--sort=yes \
		--languages=SQL \
		--extra=+fq \
		2>/dev/null
}

###
### ctags (for Shell)
###
make-ctags-shell() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/sh \
		--file-scope=yes \
		--sort=yes \
		--languages=SH \
		2>/dev/null
}

###
### ctags (for C++)
###
make-ctags-cpp() {
	test -d ".ctags" || mkdir ".ctags"
	ctags -R -f .ctags/cpp \
		--file-scope=yes \
		--sort=yes \
		--c++-kinds=+p \
		--fields=+iaS \
		--extra=+q \
		2>/dev/null
}

###
### ctags (gobal c/c++ sources for vim)
###
make-ctags-global() {

	local dest="${HOME}/.vim/ctags"

	# create tags dir if it does not exist
	if [ ! -d "${dest}" ]; then
		mkdir -p "${dest}"
	fi

	ctags \
		-R \
		--file-scope=yes \
		--sort=yes \
		--c++-kinds=+p \
		--fields=+iaS \
		--extra=+q \
		--language-force=C++ \
		-f "${dest}/cpp" /usr/include/
}

