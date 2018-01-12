################################################################################
###
### Hints (custom man pages)
###
################################################################################


###
### Bash hotkeys
###
hint-bash-hotkey() {
cat <<EOF
Ctrl + A       Go to the beginning of the line you are currently typing on
Ctrl + E       Go to the end of the line you are currently typing on
Ctrl + L       Clears the Screen, similar to the clear command
Ctrl + U       Clears the line before the cursor position. If you are at the end of the line, clears the entire line.
Ctrl + H       Same as backspace
Ctrl + R       Let’s you search through previously used commands
Ctrl + C       Kill whatever you are running
Ctrl + D       Exit the current shell
Ctrl + Z       Puts whatever you are running into a suspended background process. fg restores it.
Ctrl + W       Delete the word before the cursor
Ctrl + K       Clear the line after the cursor
Ctrl + T       Swap the last two characters before the cursor
Esc  + T       Swap the last two words before the cursor
Alt  + F       Move cursor forward one word on the current line
Alt  + B       Move cursor backward one word on the current line
Tab            Auto-complete files and folder names

!!             Last Command
!*             Last Parameters
!:n            Last n-th Parameter

EOF
}


###
### vim search/replace
###
hint-vim-search-replace() {
cat <<-EOF
:s/foo/bar/g            Change each 'foo' to 'bar' in the current line.
:%s/foo/bar/g           Change each 'foo' to 'bar' in all lines.
:5,12s/foo/bar/g        Change each 'foo' to 'bar' for all lines from line 5 to line 12 inclusive.
:'a,'bs/foo/bar/g       Change each 'foo' to 'bar' for all lines from mark a to mark b inclusive.
:.,\$s/foo/bar/g         Change each 'foo' to 'bar' for all lines from the current line (.)
                        to the last line ($) inclusive.
:.,+2s/foo/bar/g        Change each 'foo' to 'bar' for the current line (.) and the two next lines (+2).
:%s/foo/bar/g           Equivalent to :1,\$s/foo/bar/g (change all lines).
:g/^baz/s/foo/bar/g     Change each 'foo' to 'bar' in each line starting with 'baz'.

/copyright \C           Case sensitive
/Copyright \c           Case insensitive

daw                     delete the word under the cursor
caw                     delete the word under the cursor and put you in insert mode

diSYMBOL                delete between qoutes; or other symbols; like brackets, single qoutes ..etc
ciSYMBOL                -- || -- but be in insert mode afterwords

dtSYMBOL                delete until charator
dTSYMBOL                delete until charator; backwards
EOF
}


###
### vim panes
###
hint-vim-pane() {
cat <<EOF
Master key: Ctrl+W
:vsplit  :vs   v        split vertical
:split   :sp   s        split horizontal
hjkl                    move between panes
q                       kill a pane
:ls                     show open buffer
:b [number]             open buffer with number
EOF
}


###
### vim ctags
###
hint-vim-ctags() {
cat <<EOF
Keys
-----------------
<Ctrl> + ]             Goto Definition of currently cursored function
<Ctrl> + T             Go back to where you came from

# Commands
-----------------
:ts <func>[TAB]        Show List of available function definitions
:ta[g] <func>[TAG]     Search for definition
EOF
}


###
### Profanity
###
hint-profanity() {
cat <<EOF
# ---- Show Buddies
/roster show               Show the roster
/roster hide               Hide the roster (default)
/roster show offline       Show offline contacts
/roster hide offline       Hide offline contacts (default)
/roster show resource      Show connected resources for each online contact
/roster hide resource      Hide connected resources for each online contact (default)
/roster by group           Group contacts by roster group
/roster by presence        Group contacts by presence
/roster by none            Do not group contacts (default)

# ---- OTR
/otr start


# ---- Configuration
http://www.profanity.im/configuration.html
http://www.profanity.im/accounts.html

EOF
}


###
### MySQL
###
hint-mysql() {
cat <<EOF
Autocompletion

Inside mysql client
----------------------------------
mysql> \#
mysql> describe someTableW[TAB]


Before starting client
----------------------------------
mysql --auto-rehash -uroot


In /etc/my.cnf
----------------------------------
[mysql]
auto-rehash

EOF
}

