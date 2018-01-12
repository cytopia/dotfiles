"------- Dein: Init {{{
"-------------------------------------------------------------------------------
"
" Usage
" :call dein#install()
" :call dein#build()
" :call dein#check_update()
" :call dein#update()
"
" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
	set nocompatible    " Be iMproved
endif

"set runtimepath+=~/.config/nvim/bundles/repos/github.com/Shougo/dein.vim
set runtimepath+=~/.local/share/nvim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(expand('~/.local/share/nvim/bundles'))
	call dein#begin(expand('~/.local/share/nvim/bundles'))

	" Let dein manage dein
	" Required:
	call dein#add(expand('~/.local/share/nvim/bundles/repos/github.com/Shougo/dein.vim'))
"}}}
"------- Dein: Plugins {{{
"-------------------------------------------------------------------------------
" ------------ Vim extension {{{
	" Vimproc to asynchronously run commands (Unite)
	call dein#add('Shougo/vimproc.vim', {'build': 'make'})
	call dein#add('Shougo/vimshell.vim')
"}}}
" ------------ File explorer/tabs {{{
	" FZF
	call dein#add('junegunn/fzf', {'build': './install --bin'})
	call dein#add('junegunn/fzf.vim')

	" [Fuzzy Finder] Unite
	" Ultimate navigation plugin
	" @replaces:	command_T / ctrl_P
	" @required by:	vimfiler
	call dein#add('Shougo/unite.vim')

	" [Explorer] NERDTree
	call dein#add('scrooloose/nerdtree.git')
	call dein#add('jistr/vim-nerdtree-tabs')
	call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
"}}}
" ------------ Autocompletion {{{
	let g:ycm_python_binary_path = '/usr/bin/python3'
	"call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer --gocode-completer'})
	"call dein#add('Valloric/YouCompleteMe', {'build': './install.py --clang-completer'})
	call dein#add('Valloric/YouCompleteMe', {'build': './install.py'})
"}}}
" ------------ Tagbar {{{
	call dein#add('majutsushi/tagbar', {'on_cmd': ['TagbarToggle']})
	call dein#add('vim-php/tagbar-phpctags.vim', {'build': 'make'})
"}}}
" ------------ Git {{{
	" Show git status of line + , - or ~
	call dein#add('airblade/vim-gitgutter')

	" Show git repository changes in the current file
	call dein#add('tpope/vim-fugitive')

	" Git viewer
	call dein#add('gregsexton/gitv')
"}}}
" ------------ Syntax linting{{{
	call dein#add('scrooloose/syntastic')
"}}}
" ------------ Colorschemes {{{
	call dein#add('notpratheek/vim-luna')
	call dein#add('junegunn/seoul256.vim')
	call dein#add('geoffharcourt/one-dark.vim')
	call dein#add('tomasr/molokai')
	call dein#add('w0ng/vim-hybrid')
	call dein#add('octol/vim-cpp-enhanced-highlight')
"}}}
" ------------ Whitespace {{{
	call dein#add('ntpeters/vim-better-whitespace')
"}}}
" ------------ Syntax highlighter {{{
	call dein#add('elzr/vim-json', {'on_ft': ['json']})
	call dein#add('jelera/vim-javascript-syntax', {'on_ft': ['javascript']})
	call dein#add('hail2u/vim-css3-syntax', {'on_ft': ['css']})
	call dein#add('groenewege/vim-less', {'on_ft': ['less']})
	call dein#add('cakebaker/scss-syntax.vim', {'on_ft': ['sass', 'scss']})
	call dein#add('tmux-plugins/vim-tmux', {'on_ft': ['tmux']})
	call dein#add('PotatoesMaster/i3-vim-syntax', {'on_ft': ['i3']})
	call dein#add('pearofducks/ansible-vim')
"}}}
" ------------ Misc {{{

	" ---- DIFF
	" Diff complete directories
	" Usage: :DirDiff <dir1> <dir2>
	call dein#add('will133/vim-dirdiff', {'on_cmd': ['DirDiff']})

	" ---- Editor
	" obey .editorconfig
	call dein#add('editorconfig/editorconfig')

	" ---- Hex color codes
	call dein#add('gko/vim-coloresque')

	" ---- Fonts
	" Must be loaded after all plugins that used the devicons
	" put last
	call dein#add('ryanoasis/vim-devicons')
"}}}
"}}}
"------- Dein: Destructor {{{
"-------------------------------------------------------------------------------
	" Required:
	call dein#end()
	call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif
"}}}
"------- DEFAULT {{{
"-------------------------------------------------------------------------------
set nocompatible				" Use vim defaults instead of vi defaults
set autoread					" Automatically reload file contents when changed from outside
set backspace=indent,eol,start	" Allow backspacing over everything in insert mode
set hidden 						" Start new file with :e without having to save current
set history=50					" Remember commands entered in :
set undolevels=100	 			" Use many levels of undo
set shell=$SHELL				" Set Shell
set more						" to show pages using `more` in command outpouts
set title						" show vim in terminal title

" Drawing
set lazyredraw					" Do not redraw screen while executing macros or commands
set ttyfast 					" Use fast tty updates (better screen redraw)

" for color terminals which attempts to bring the 256 color version as close as possible
"let g:rehash256 = 1

" Fix tmux term variable
" Make Vim recognize XTerm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
	" Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
	execute "set t_kP=\e[5;*~"
	execute "set t_kN=\e[6;*~"
	" Arrow keys http://unix.stackexchange.com/a/34723
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" Enable syntax highlighting
syntax on
" Syntax coloring lines that are too long just slows down the world
"set synmaxcol=128
"set synmaxcol=200		" Only show 200 columns

"if has('nvim')
"	let g:python_host_prog = '/usr/bin/python'
"endif
"}}}
"------- Appearance: Colorscheme {{{
"-------------------------------------------------------------------------------

if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Use true colors
set termguicolors

" Molokai colorscheme
colorscheme molokai
let g:molokai_original = 1

" Seoul colorscheme
"let g:seoul256_background = 233
"colorscheme seoul256

" Hybrid colorscheme
"let g:hybrid_use_Xresources = 1
"set background=dark
"colorscheme luna

" Colorscheme for calling vimdiff from inside vim
autocmd FilterWritePre * if &diff | colorscheme hybrid | endif


" Ignore whitespace in diff mode
if &diff
    " diff mode
    set diffopt+=iwhite
	set diffexpr=DiffW()
endif


" Vertical windows for diff
set diffopt+=vertical

" Colorscheme for calling vimdiff from the command line
if &diff
	colorscheme hybrid
endif

" Fix tmux colorbug when using term=xterm-256color
" Fixing Vim's Background Color Erase because
" tmux does not support Background Color erase (bce)
" @see https://sunaku.github.io/vim-256color-bce.html
" @see https://github.com/tmux/tmux/issues/109
if &term =~ '256color'
	set t_ut=
endif
"" Fix tmux term variable
"if &term =~ '^screen'
"	" disable Background Color Erase (BCE) so that color schemes
"	" render properly when inside 256-color tmux and GNU screen.
"	" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"	set t_ut=
"endif
"
"" Set the number of colors
"if !has('gui_running')
"	set t_Co=256
"endif

"}}}
"------- Appearance: Cursor {{{
"-------------------------------------------------------------------------------
"set cursorline					" show a line where the cursor is
set nocursorline
"set cursorline cursorcolumn	" Show"vertical and horizontal line of the cursor
set nocursorcolumn
" Change cursor shape between insert and normal mode
if has('nvim')
	let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
else
	if exists('$TMUX')
		" iTerm2 inside tmux
		let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
		let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
		let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
	else
		" iTerm2
		let &t_SI = "\<Esc>]50;CursorShape=1\x7"
		let &t_SR = "\<Esc>]50;CursorShape=2\x7"
		let &t_EI = "\<Esc>]50;CursorShape=0\x7"
	endif
endif
"}}}
"------- Appearance: Folding {{{
"-------------------------------------------------------------------------------
" fold color
hi Folded cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none
"}}}
"------- Appearance: Line numbers {{{
"-------------------------------------------------------------------------------
set number						" show line numbers
set relativenumber				" show relative line numbers
set numberwidth=5				" reserve 5 Spaces for the numbering (left)
"}}}
"------- Appearance: Statusbar {{{
"-------------------------------------------------------------------------------
set showmode					" Show INSERT, REPLACE or VISUAL in Statusbar
"set showcmd						" Show partial cmd in last line of the screem (slow)
set ruler						" Show line and column number
set laststatus=2				" Always show status line
set cmdheight=1

" Define colors
hi User1 guifg=#ffdad8  guibg=#880c0e			ctermfg=15 ctermbg=52
hi User2 guifg=#000000  guibg=#F4905C			ctermfg=16 ctermbg=166
hi User3 guifg=#292b00  guibg=#f4f597			ctermfg=16 ctermbg=192
hi User4 guifg=#112605  guibg=#aefe7B			ctermfg=16 ctermbg=84
hi User5 guifg=#051d00  guibg=#7dcc7d			ctermfg=16 ctermbg=72
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold	ctermfg=15 ctermbg=52 cterm=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb			ctermfg=15 ctermbg=13
hi User9 guifg=#ffffff  guibg=#810085			ctermfg=15 ctermbg=90
hi User0 guifg=#ffffff  guibg=#094afe			ctermfg=15 ctermbg=16

" Helper function
function! HighlightSearch()
	if &hls
		return 'H'
	else
		return ''
	endif
endfunction

" Format status bar
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot
"}}}
"------- Appearance: Whitespace {{{
"tes
"-------------------------------------------------------------------------------
" Toggle whitespace characters on
set list

" Specify which list characters to show and what symbol to use
set listchars=tab:→\ ,space:·,eol:↵,trail:·,extends:↷,precedes:↶
"set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶

" make the highlighting of tabs less annoying
"highlight SpecialKey ctermbg=235
"highlight NonText ctermbg=235

" Make list characters the same color as the normal background
" so I do not see them.
" I will however see them, when I highlight text
hi SpecialKey ctermfg=235 guifg=#262626
hi NonText    ctermfg=235 guifg=#262626

" show ellipsis at breaking
set showbreak=…
"set showbreak=↪
"}}}
"------- Appearance: Windows / Panes {{{
"-------------------------------------------------------------------------------
set fillchars+=vert:│			" better looking for windows separator
"}}}
"------- Behavior: Autocomplete {{{
"-------------------------------------------------------------------------------
" Vim Omni completion.
" Ctrl+X Ctrl+O     Omni completion
" Ctrl+X Ctrl+F     Filename completion
" Ctrl+X Ctrl+P     Keywords in current file (backwords in file)
" Ctrl+X Ctrl+N     Keywords in current filea (forward in file)
" Ctrl+P            Keywords in 'complete' (backwards in file)
" Ctrl+N            Keywords in 'complete' (forward in file)


" Globally enable default Omnicompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_NamespaceSearch		= 1
let OmniCpp_GlobalScopeSearch	= 1
let OmniCpp_ShowAccess			= 1 "Show access in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "Show prototype in pop-up (function params)
let OmniCpp_DisplayMode			= 1
let OmniCpp_ShowScopeInAbbr		= 1 "Show namespace in pop-up
let OmniCpp_SelectFirstItem		= 1 "Select first item in pop-up
let OmniCpp_MayCompleteDot		= 1 " autocomplete after .
let OmniCpp_MayCompleteArrow	= 1 " autocomplete after ->
let OmniCpp_MayCompleteScope	= 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces	= ["std", "_GLIBCXX_STD"]


autocmd FileType c				setlocal omnifunc=ccomplete#Complete
autocmd FileType css			setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown	setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript		setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType php			setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType python			setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby,eruby		setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml			setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType sql			setlocal omnifunc=sqlcomplete#Complete

"set completeopt=menuone,menu			" Show menu by default
"set completeopt=longest,menuone,preview " Show menu and preview window on top
set completeopt=menuone,menu,longest	" Show menu and insert longest
"}}}
"------- Behavior: Autocomplete (wildmenu) {{{
"-------------------------------------------------------------------------------
" When 'wildmenu' is on, command-line completion operates in an enhanced
" mode.  On pressing 'wildchar' (usually <Tab>) to invoke completion,
set wildmenu
"set wildmode=longest,list,full
set wildmode=longest,list
"set wildmode=list:longest

"set wildignore+=.hg,.git,.svn " Version Controls"
"set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
"set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
"set wildignore+=*.spl "Compiled speolling world list"
"set wildignore+=*.sw? "Vim swap files"
"set wildignore+=*.DS_Store "OSX SHIT"
"set wildignore+=*.luac "Lua byte code"
"set wildignore+=*.pyc "Python Object codes"
"set wildignore+=*.orig "Merge resolution files"
"set wildignore+=*.class "java/scala class files"
"set wildignore+=.sass-cache
"}}}
"------- Behavior: Autocomplete (ctags/cscope) {{{
"-------------------------------------------------------------------------------
" Default/Generic tag file
set tags=tags,.tags
"
" Filetype specific tag files (This is used for global IDE tags)
autocmd FileType c				set tags=.ctags/cpp,$HOME/.vim/ctags/cpp
autocmd FileType cpp			set tags=.ctags/cpp,$HOME/.vim/ctags/cpp
autocmd FileType css			set tags=.ctags/css,$HOME/.vim/ctags/css
autocmd FileType java			set tags=.ctags/java,$HOME/.vim/ctags/java
autocmd FileType javascript		set tags=.ctags/js,$HOME/.vim/ctags/js
autocmd FileType html			set tags=.ctags/html,$HOME/.vim/ctags/html
autocmd FileType markdown		set tags=.ctags/md,$HOME/.vim/ctags/md
autocmd FileType php			set tags=.ctags/php,$HOME/.vim/ctags/php
autocmd FileType sh				set tags=.ctags/sh,$HOME/.vim/ctags/sh
"}}}
"------- Behavior: Bell {{{
"-------------------------------------------------------------------------------
set noerrorbells				" Don't beep
set novisualbell				" Disable visual bell
set t_vb=						" Tell visual bell to do nothing
"}}}
"------- Behavior: Bracket matching {{{
"-------------------------------------------------------------------------------
"let g:loaded_matchparen=1		" Disable Bracket Matching
"set showmatch					" show matching bracket (briefly jump)
"set matchtime=5					" 0.5 sek matching show time

"}}}
"------- Behavior: Clipboard {{{
"-------------------------------------------------------------------------------
" Linux/Mac OSX Clipboard Synchronization
" Make sure vim has +clipboard support
" vim --version | grep clipboardA
" accordingly +xterm_clipboard
" OSX + Windows: unnamed and unnamedplus are equal
" Linux: unnamed = 'selection' unnamedplus = 'primary (Ctrl+C)'
" Cross-platform version here:
set clipboard^=unnamed,unnamedplus
"}}}
"------- Behavior: Folding {{{
"-------------------------------------------------------------------------------
" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker			" fold based on marker
"set foldmethod=syntax			" fold based on indent
"
set foldnestmax=5				" deepest fold is 10 levels
"set nofoldenable				" don't fold by default
"set foldlevel=1					"
"}}}
"------- Behavior: Line wrapping {{{
"-------------------------------------------------------------------------------
set wrap						" turn on line wrapping
set linebreak					" set soft wrapping

"}}}
"------- Behavior: Mouse {{{
"-------------------------------------------------------------------------------
if has('mouse')
	set mouse=a
	if !has('nvim')
		if has('mouse_sgr')
			set ttymouse=sgr
		elseif has('mouse_urxvt')
			set ttymouse=urxvt
		else
			set ttymouse=xterm2
		endif
	endif
endif
"}}}
"------- Behavior: Scrolling {{{
"-------------------------------------------------------------------------------
set scrolloff=3					" 3 lines above/below cursor when scrolling
"}}}
"------- Behavior: Searching {{{
"-------------------------------------------------------------------------------
set noignorecase				" Case-sensitive search (instead of ignorecase)
set smartcase					" then enable smart case (case-sensetive if you use uppercase characters)
set magic						" change the way backslashes are used in search patterns
set incsearch 					" Show search pattern while typing
set hlsearch 					" Highlight the search
"}}}
"------- Behavior: Windows / Panes {{{
"-------------------------------------------------------------------------------
" Resize the divisions if the Vim window size changes
au VimResized * exe "normal! \<c-w>="
"}}}
"------- Editing: Encoding {{{
"-------------------------------------------------------------------------------
"scriptencoding utf-8
if !has('nvim')
	set encoding=utf-8				" The encoding displayed
endif
set fileencoding=utf-8			" The encoding written to file."
"set fileencodings=utf-8		" Reading: (Force encoding) Fileencoding for existing file
"}}}
"------- Editing: Indentation {{{
"-------------------------------------------------------------------------------
set autoindent					" Copy the indentation from the previous line
set smartindent 				" Do not smart intend

if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on
endif
"}}}
"------- Editing: Line feeds {{{
"-------------------------------------------------------------------------------
set fileformat=unix				" Use unix line feeds
"}}}
"------- Editing: Tabs vs Spaces {{{
"-------------------------------------------------------------------------------
set noexpandtab					" Insert tabs rather than spaces for <TAB>
set smarttab					" tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4					" Number of spaces a tab counts for
set softtabstop=4				" Edit as if the tabs are 4 characters wide
set shiftwidth=4				" Number of spaces to use for indent and unindent
set shiftround					" use multiple of shiftwidth when indenting with '<' and '>'
"}}}
"------- Filetypes {{{
"-------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.less setfiletype less
autocmd BufNewFile,BufRead *i3/config setfiletype i3
autocmd BufNewFile,BufRead *tmux.conf*,Tmuxfile,*tmux/config setfiletype tmux
autocmd BufNewFile,BufRead *.changelog setfiletype changelog
autocmd BufNewFile,BufRead php.ini setfiletype dosini
autocmd BufNewFile,BufRead php-fpm.conf setfiletype dosini
autocmd BufNewFile,BufRead my.cnf setfiletype dosini
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.cpp,*.hpp set filetype=cpp
autocmd BufNewFile,BufRead *.vimpagerrc set filetype=vim
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
"}}}
"------- Keymappings {{{
"-------------------------------------------------------------------------------
" ---- Leader & LocalLeader
" leader (default \)
" localleader (defaults to leader: \)
"let mapleader = ','
"let g:mapleader = ','
"let maplocalleader= ' '

" when you forgot to sudo before editing a file that
" requires root privileges (typically /etc/hosts).
" This lets you use w!! to do that after you opened the file already:
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

"nnoremap <F10> :!open % -a Google\ Chrome<CR>
nnoremap <F10> :!chromium %<CR>

" Toggle Paste mode via F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Better writening/closing
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev wQ wq

" Easy window navigation by word
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Select all and jump cursor back to current position
map <C-a> ggVG<C-o><C-o>

"}}}
"------- Plugin: Unite {{{
"-------------------------------------------------------------------------------
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
	\ 'ignore_pattern', join([
		\ '\.git/',
		\ '\.svn/',
		\ '\.sass-cache/',
		\ 'tmp/',
		\ 'bundle/'
	\], '\|'))

let g:default_context = {
    \ 'winheight' : 15,
    \ 'update_time' : 100,
    \ 'prompt' : '➤ ',
    \ 'enable_start_insert' : 1,
    \ 'enable_short_source_names' : 0,
    \ 'marked_icon' : '✓',
    \ 'ignorecase' : 1,
    \ 'smartcase' : 1,
\ }
call unite#custom#profile('default', 'context', default_context)
"
"
""let g:unite_enable_ignore_case	= 1
""let g:unite_enable_smart_case	= 1
""let g:unite_enable_start_insert	= 1
"let g:unite_winheight			= 15
"let g:unite_split_rule			= 'botright'
"let g:unite_prompt				= '➤ '
"let g:unite_data_directory		= $HOME.'/.vim/tmp/unite'
"
"" GREP FILES
"" Use ag in unite grep source.
""let g:unite_source_grep_command = 'ag'
""let g:unite_source_grep_default_opts =
""	\ '-i --line-numbers --nocolor --nogroup --smart-case --ignore ' .
""	\  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
""let g:unite_source_grep_recursive_opt = ''
"
if executable('ag')
    let g:unite_source_grep_command='ag'
    "let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
    let g:unite_source_grep_default_opts='--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt=''
    "let g:unite_source_grep_search_word_highlight = 'ctermfg=15 ctermbg=2'
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-group --no-color'
    let g:unite_source_grep_recursive_opt=''
    "let g:unite_source_grep_search_word_highlight = 'ctermfg=15 ctermbg=2'
endif

" file			# files in current directory
" file_rec		# recursive files
" buffer		# open files
" buffer_tab	# current tab only
" file_mru		# recent files
" everyhthing	# Search everything


" Ctrl+P: Show all files
"nnoremap <C-p> :Unite -start-insert -no-split -buffer-name=files file_rec/async:!<cr>
"nnoremap <C-p> :Unite -start-insert -no-split -auto-preview -winheight=10 file_rec:!<CR>

" Ctrl+O: Show all open files
"nnoremap <C-o> :Unite -start-insert -no-split -auto-preview -winheight=10 buffer<CR>

" Ctrl+F: Search current document
nnoremap <C-f> :Unite -start-insert line<CR>

" Ctrl+G: Search all documents from current path
nnoremap <C-g> :Unite -silent -auto-resize -buffer-name=ag grep:.<CR>
"}}}
"------- Plugin: Unite Menu {{{
"-------------------------------------------------------------------------------
" ------------ Unite Menu (DEFAULT) {{{
let g:unite_source_menu_menus = {}

" menu prefix key (for all Unite menus)
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
"
" menus menu
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR>
"}}}
" ------------ Unite Menu (Files) {{{
let g:unite_source_menu_menus.files = {
\ 'description' : '          files & dirs
\                                          ⌘ [space]o',
\}
let g:unite_source_menu_menus.files.command_candidates = [
    \['▷ open file                                                  ⌘ ,o',
        \'Unite -start-insert file'],
    \['▷ open more recently used files                              ⌘ ,m',
        \'Unite file_mru'],
    \['▷ open file with recursive search                            ⌘ ,O',
        \'Unite -start-insert file_rec/async'],
    \['▷ edit new file',
        \'Unite file/new'],
    \['▷ search directory',
        \'Unite directory'],
    \['▷ search recently used directories',
        \'Unite directory_mru'],
    \['▷ search directory with recursive search',
        \'Unite directory_rec/async'],
    \['▷ make new directory',
        \'Unite directory/new'],
    \['▷ change working directory',
        \'Unite -default-action=lcd directory'],
    \['▷ know current working directory',
        \'Unite output:pwd'],
    \['▷ junk files                                                 ⌘ ,d',
        \'Unite junkfile/new junkfile'],
    \['▷ save as root                                               ⌘ :w!!',
        \'exe "write !sudo tee % >/dev/null"'],
    \['▷ quick save                                                 ⌘ ,w',
        \'normal ,w'],
    \['▷ open ranger                                                ⌘ ,x',
        \'call RangerChooser()'],
    \['▷ open vimfiler                                              ⌘ ,X',
        \'VimFiler'],
    \]
nnoremap <silent>[menu]o :Unite -silent -winheight=17 -start-insert
            \ menu:files<CR>
"}}}
" ------------ Unite Menu (Git) {{{
"}}}
let g:unite_source_menu_menus.git = {
    \ 'description' : '            gestionar repositorios git
        \                            ⌘ [space]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt',
        \'normal ,gt'],
    \['▷ git status       (Fugitive)                                ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff         (Fugitive)                                ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit       (Fugitive)                                ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log          (Fugitive)                                ⌘ ,gl',
        \'exe "silent Glog | Unite quickfix"'],
    \['▷ git blame        (Fugitive)                                ⌘ ,gb',
        \'Gblame'],
    \['▷ git stage        (Fugitive)                                ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout     (Fugitive)                                ⌘ ,go',
        \'Gread'],
    \['▷ git rm           (Fugitive)                                ⌘ ,gr',
        \'Gremove'],
    \['▷ git mv           (Fugitive)                                ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
        \'Git! pull'],
    \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git cd           (Fugitive)',
        \'Gcd'],
    \]

nnoremap <silent>[menu]g :Unite -silent -start-insert menu:git<CR>
"}}}
"------- Plugin: GitGutter {{{
"-------------------------------------------------------------------------------
let g:gitgutter_max_signs = 5000  " default value"
"}}}
"------- Plugin: Syntastic {{{
"-------------------------------------------------------------------------------
"if neobundle#tap('syntastic')

	set statusline+=%#warningmsg#
	"set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 1						" Only check when writing
	let g:syntastic_check_on_open = 0						" Do not check when opening
	let g:syntastic_check_on_wq = 1
	let g:syntastic_aggregate_errors = 1
	let g:syntastic_quiet_messages = { "type": "style" }	" Ignore all Style warnings

	let g:syntastic_warning_symbol="⚠"
	let g:syntastic_error_symbol="✗"
	let g:syntastic_enable_signs=1

	let g:syntastic_enable_perl_checker = 1

	" ---- HTML
	let g:syntastic_html_tidy_exec = 'tidy5'

	" ---- PHP
	" phpcs: CodeSniffer	(Check PHP Code against coding standard)
	" phpmd: Mess Detector
	" phpcc: Code Coverage
	let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
	let g:syntastic_php_phpcs_args = '-s --standard=PSR1' " always check against PSR1
	"let g:syntastic_php_phpcs_args = '-s -n --standard=PSR2' " always check against PSR2

	" ---- Javascript
	"let g:syntastic_javascript_checkers = ['eslint', 'jslint', 'jshint']
	let g:syntastic_javascript_checkers = ['eslint']
	let g:syntastic_javascript_eslint_args = "--global $,document --rule 'quotes: [1,single]'"
	"let g:syntastic_javascript_jslint_args = "--white"

	" ---- CSS
	let g:syntastic_css_checkers = []	" Disable css linting (comment out to enable)
	let g:syntastic_css_csslint_args = "--ignore=adjoining-classes"

	" ---- Bash/sh
	let g:syntastic_sh_checkers				= ['shellcheck', 'checkbashisms', 'sh']
	let g:syntastic_sh_checkbashisms_args	= '-x'

	" ---- Yaml
	let g:syntastic_yaml_checkers			= ['yamllint']
	let g:syntastic_yaml_yamllint_args		= '-d "{ extends: default, rules: {line-length: {max: 1000}} }"'

	" Disable linting for vimdiff
	autocmd FilterWritePre * if &diff | exe ":SyntasticToggleMode" | endif


	"call neobundle#untap()
"endif


"}}}
"------- Plugin: TagBar {{{
"-------------------------------------------------------------------------------
nmap <leader>t :TagbarToggle<CR>

"highlight TagbarScope guifg=Green ctermfg=Green
"highlight TagbarType guifg=Red ctermfg=Green
highlight TagbarSignature guifg=Yellow ctermfg=Green
"highlight TagbarScope guifg=Yellow ctermfg=Green

"TagbarType
"TagbarSignature
"TagbarPseudoID
"TagbarVisibilityPublic
"TagbarVisibilityProtected
"TagbarVisibilityPrivate


"let g:tagbar_type_css = {
"	\ 'ctagstype'	: 'Css',
"	\ 'kinds'		: [
"		\ 'c:classes',
"		\ 's:selectors',
"		\ 'i:identities'
"	\ ]
"\ }

let g:tagbar_type_javascript = {
	\ 'ctagstype'	: 'JavaScript',
	\ 'kinds'		: [
		\ 'o:objects',
		\ 'f:functions',
		\ 'a:arrays',
		\ 's:strings'
	\ ]
\ }

"}}}
"------- Plugin: TagBar-phpctags {{{
"-------------------------------------------------------------------------------
let g:tagbar_phpctags_bin="phpctags"
let g:tagbar_phpctags_memory_limit = '256M'
"}}}
"------- Plugin: NerdTree {{{

" Key mappings
"map <C-n> :NERDTreeToggle<CR>

" Options
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"let g:NERDTreeDirArrowExpandable = '📁'
"let g:NERDTreeDirArrowCollapsible = '📂'
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=0

" Change current working directory accordingly when loading bookmarks
let NERDTreeChDirMode=2

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Give different filetypes different colors in NERDTree
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"	 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"	 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction
"call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" NerdTree colors
hi Directory guifg=#7F7F84 ctermfg=red


"}}}
"------- Plugin: NerdTreeHighlight {{{
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
"}}}
"------- Plugin: NerdTreeTabs {{{
map <C-n> :NERDTreeTabsToggle<CR>

" Automatically find and select currently opened file in NERDTree.
let g:nerdtree_tabs_autofind = 1

let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

"}}}
"------- Plugin: NerdTree-Git {{{
"let g:NERDTreeIndicatorMapCustom = {
"    \ "Modified"  : "✹",
"    \ "Staged"    : "✚",
"    \ "Untracked" : "✭",
"    \ "Renamed"   : "➜",
"    \ "Unmerged"  : "═",
"    \ "Deleted"   : "✖",
"    \ "Dirty"     : "✗",
"    \ "Clean"     : "✔︎",
"    \ "Unknown"   : "?"
"    \ }
""}}}
"------- Plugin: Vimfiler {{{
"-------------------------------------------------------------------------------
"" Replace Default Vim Explorer
"let g:vimfiler_as_default_explorer = 1
"
"" Change working directory to current file
""autocmd BufEnter * silent! lcd %:p:h
"
"" close vimfiler automatically when there are only vimfiler open
"autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
"
"" Nice Icons
"let g:vimfiler_tree_leaf_icon = '├'
"let g:vimfiler_tree_opened_icon = '┐'
"let g:vimfiler_tree_closed_icon = '─'
"let g:vimfiler_file_icon = '┄'
"let g:vimfiler_marked_file_icon = '✓'
"let g:vimfiler_readonly_file_icon = '✗'
"
"" Quick Open/CLose With Ctrl-E
"nnoremap <C-n> :VimFilerExplorer -toggle<CR>
"nnoremap <C-m> :VimFilerExplorer -find<CR>
""nnoremap <C-m> :VimFilerBufferDir -explorer -find -toggle<CR>
"
"
"}}}
"------- Plugin: Ctrl-P {{{
"-------------------------------------------------------------------------------

"" Set higher max file limit:100, default was 10
"" The position: (default: bottom)
""  top - show the match window at the top of the screen.
""  bottom - show the match window at the bottom of the screen.
""The listing order of results: (default: btt)
""  order:ttb - from top to bottom.
""  order:btt - from bottom to top.
""
""The minimum and maximum heights:
""  min:{n} - show minimum {n} lines (default: 1).
""  max:{n} - show maximum {n} lines (default: 10).
""
""The maximum number of results:
""  results:{n} - list maximum {n} results (default: sync with max height).
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:200'
"
"" Do not let CtrlP change working directory!!
""let g:ctrlp_working_path_mode = 'rw'
"let g:ctrlp_working_path_mode = 0
"
"set grepprg=ag\ --nogroup\ --nocolor
"
"let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
"      \ --ignore .git
"      \ --ignore .svn
"      \ --ignore .hg
"      \ --ignore .DS_Store
"      \ --ignore "**/*.pyc"
"      \ -g ""'
"" ag is fast enough that CtrlP doesn't need to cache
"let g:ctrlp_use_caching = 0
"
"
"" CtrlP on C-P
""let g:ctrlp_map = '<c-p>'
""let g:ctrlp_cmd = 'CtrlP'
"
"" CtrlP for Tags on Leader-P
""nnoremap <leader>p :CtrlPTag<cr>

"}}}
"------- Plugin: Instant-Markdown {{{
"-------------------------------------------------------------------------------
" Do not auto start
"let g:instant_markdown_autostart = 0

" Trigger manually via
" :InstantMarkdownPreview
"}}}
"------- Plugin: IndentLine {{{
"-------------------------------------------------------------------------------
" Turned off, as it does not support tabs yet
"Vim
"let g:indentLine_color_term = 239
    
"GVim
"let g:indentLine_color_gui = '#A4E57E'
"let g:indentLine_color_gui = '#FF0000'

" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)

" Change Indent Char
"let g:indentLine_char = '┆'

" Change Conceal Behaviour
"let g:indentLine_concealcursor = 'vc' "(default 'inc')
"let g:indentLine_conceallevel = 2 "(default 2)

" Performance
"let g:indentLine_enabled = 0
"let g:indentLine_faster = 1
"}}}
"------- Plugin: Editorconfig {{{
"-------------------------------------------------------------------------------
" :help editorconfig
"
"}}}
"------- Plugin: MiniBufExplorer {{{
"-------------------------------------------------------------------------------
" MiniBufExpl Colors
"hi MBENormal               guifg=#808080 guibg=fg
"hi MBEChanged              guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
"hi MBEVisibleChanged       guifg=#F1266F guibg=fg
"hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
"hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg
"}}}
"------- Plugin: FZF {{{
"-------------------------------------------------------------------------------
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
"let g:fzf_layout = { 'window': 'enew' }
"let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ---- Command options

" [Files] Extra options for fzf
"   e.g. File preview using Highlight
"        (http://www.andre-simon.de/doku/highlight/en/highlight.html)
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'


" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

"let g:fzf_launcher = 'urxvt -geometry 120x30 -e sh -c %s'
" Ctrl+P: Fuzzy search files
nnoremap <C-p> :Files<CR>
nnoremap <C-o> :Buffers<CR>

" Insert mode map
"imap <c-x><c-space> <plug>(fzf-complete-line)


"}}}
"------- Plugin: YouCompleteMe {{{
"-------------------------------------------------------------------------------
let g:ycm_server_python_interpreter = "/usr/bin/python"
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"}}}
"------- Plugin: VimShell {{{
"-------------------------------------------------------------------------------
" Run vimshell
"    :VimShell
"
" Run vimshell in new Tab
"    :VimShellTab
"
" Run vimshell in new Split
"    :VimShellPop
"}}}
"------- Plugin: vim-devicons {{{
"-------------------------------------------------------------------------------
" Note: must be configured last, after all plugins are configured
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable_airline_tabline = 0
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_flagship_statusline = 0
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
"}}}


function DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

" vim: set ts=4:
