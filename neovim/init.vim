"------- Vim Core Plugins {{{
"-------------------------------------------------------------------------------
" Disable vim distribution plugins
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1   " accurate but very slow
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_rrhelper          = 1   " ?
let g:loaded_shada_plugin      = 1   " ?
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:netrw_nogx               = 1   " disable netrw's gx mapping.
"}}}
"------- Dein: Init {{{
"-------------------------------------------------------------------------------
" Install
"  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
"  sh ./installer.sh ~/.local/share/nvim/bundles
" Usage
" :call dein#install()
" :call dein#build()
" :call dein#check_update()
" :call dein#update()
" :call dein#check_lazy_plugins()
" :h dein-options

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if &compatible
	set nocompatible    " Be iMproved
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.local/share/nvim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/nvim/bundles')
	call dein#begin('~/.local/share/nvim/bundles')
	" Let dein manage dein
	call dein#add('~/.local/share/nvim/bundles/repos/github.com/Shougo/dein.vim')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
"}}}
"------- Dein: Plugins {{{
"
" Use 'hook_add'    for general configuration
" Use 'hook_source' for everything that directly calls plugin functions
"
"-------------------------------------------------------------------------------
" ------------ [Startup Loading] Colorschems {{{
	call dein#add('tomasr/molokai')     " Default
	call dein#add('w0ng/vim-hybrid')    " Diff view
"}}}
" ------------ [Startup Loading] General {{{
	call dein#add('sgur/vim-editorconfig')      " Respect .editorconfig file
	call dein#add('itchyny/vim-parenmatch')     " Faster than built-in paren matching
"}}}
" ------------ [Startup Loading] Whitespace {{{
	call dein#add('ntpeters/vim-better-whitespace')
"}}}
" ------------ [Startup Loading] File Explorer {{{
	call dein#add('scrooloose/nerdtree.git')
	call dein#add('scrooloose/nerdtree-git-plugin.git')
"}}}
" ------------ [Lazy Loading: Command] Tagbar / Function list {{{
	call dein#add('majutsushi/tagbar', {'on_cmd': ['TagbarToggle', 'TagbarOpen']})
	"call dein#add('liuchengxu/vista.vim', {'on_cmd': ['Vista', 'Vista!', 'Vista!!'],
	"\ 'depends': 'neoclide/coc.nvim'})
"}}}
" ------------ [Lazy Loading: Command] FZF {{{
	" Ctrl+P / Ctrl+O / Ctrl+G
	call dein#add('junegunn/fzf', {'build': './install --bin', 'merged': 0})
	call dein#add('junegunn/fzf.vim', {'on_cmd': ['Ag', 'Buffers', 'Files', 'Lines'],
	\ 'depends': 'junegunn/fzf'})
"}}}
" ------------ [Lazy Loading: Command/Edit] Git {{{
	call dein#add('mhinz/vim-signify', {'on_path': ['.*']})   " Async version of gitgutter

	call dein#add('chemzqm/vim-easygit', {'on_cmd':
	\ ['Gadd', 'Gcd', 'Glcd', 'Gcommit', 'Gblame', 'Gdiff', 'GdiffThis', 'Gstatus'],
	\ 'hook_add': 'let g:easygit_enable_command = 1'
	\ })
"}}}
" ------------ [Lazy Loading: Command/Edit] Syntax linting {{{
	" NeomakeInfo
	call dein#add('benekastah/neomake', {
	\ 'on_path': ['.*'],
	\ 'on_cmd': ['Neomake', 'NeomakeFile', 'NeomakeEnable', 'NeomakeToggle', 'NeomakeInfo'],
	\ 'hook_source': "call neomake#configure#automake('w')",
	\ 'hook_add': "
		\ let g:neomake_open_list = 2\n
		\ let g:neomake_virtualtext_current_error = 0\n
		\ let g:neomake_highlight_lines = 1\n
		\ let g:neomake_python_python_exe = '/usr/bin/python3'\n
		\ let g:neomake_python_enabled_makers = ['pep8', 'flake8', 'pycodestyle', 'pydocstyle']\n
		\ let g:neomake_yaml_enabled_makers = ['yamllint']\n
		\ let g:neomake_ansible_enabled_makers = ['yamllint', 'ansiblelint']\n
		\ let g:neomake_yaml_ansible_enabled_makers = ['yamllint', 'ansiblelint']\n
		\ let g:neomake_json_enabled_makers = ['jsonlint']
	\ "})
"}}}
" ------------ [Lazy Loading: FT] Syntax highlighting {{{
	call dein#add('pearofducks/ansible-vim', {'on_ft': ['ansible', 'ansible_hosts', 'jinja2'],
	\ 'hook_add': "
		\ let g:ansible_extra_keywords_highlight = 1\n
		\ let g:ansible_template_syntaxes = {
			\ '*.json.j2': 'json',
			\ '*.(ba)?sh.j2': 'sh',
			\ '*.ya?ml.j2': 'yaml',
			\ '*.xml.j2': 'xml',
			\ '*.conf.j2': 'conf',
			\ '*.ini.j2': 'ini'
		\ }
	\ "})
	call dein#add('hashivim/vim-terraform.git', {'on_ft': ['terraform']})
	call dein#add('mboughaba/i3config.vim', {'on_ft': ['i3config']})
	call dein#add('tmux-plugins/vim-tmux', {'on_ft': ['tmux']})
	call dein#add('ekalinin/Dockerfile.vim', {'on_ft': ['Dockerfile', 'docker-compose']})
	call dein#add('chr4/nginx.vim', {'on_ft': ['nginx']})
	call dein#add('raimon49/requirements.txt.vim', {'on_ft': ['requirements']})
"}}}
" ------------ [Lazy Loading] Auto Completion {{{
	" Check if it is working via: checkhealth
	" Install Language server: sudo pip install python-language-server
	" Install Language server: sudo pip3 install python-language-server
	" Install completer:
	"     :CocInstall coc-python
	"     :CocInstall coc-phpls
	"     :CocInstall coc-java
	"     :CocInstall coc-yaml
	"     :CocInstall coc-json
	call dein#add('neoclide/coc.nvim', {'merged': 0, 'rev': 'release',
	\ 'on_ft': ['python'],
	\ 'hook_source': 'call InitializeCoc()'
	\ })
"}}}
" ------------ [Lazy Loading: Command] DirDiff {{{
	" Diff complete directories
	" Usage: :DirDiff <dir1> <dir2>
	call dein#add('will133/vim-dirdiff', {'on_cmd': ['DirDiff']})
"}}}
"}}}
"------- Dein: Destructor {{{
"-------------------------------------------------------------------------------
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
" Only enable syntax when vim is starting
if has('vim_starting')
	syntax enable
endif
"}}}
"------- Default Vim Settings {{{
"-------------------------------------------------------------------------------
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set hidden                      " hide buffers when abandoned instead of unload
set autoread                    " Automatically reload file contents when changed from outside
set shell=$SHELL                " Set shell
set synmaxcol=200               " Only syntax highlight up to 200 colums (performance)

"set modeline                    " Interprets such settings: /* vi:ts=4: */
" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set modelines=0
set nomodeline

set report=0                    " Don't report on line changes (TODO:)
set signcolumn=yes              " Always show signs column

" Drawing
set lazyredraw                  " Do not redraw screen while executing macros or commands
if !has('nvim')
	if exists('$TMUX')
		set ttyfast             " Use fast tty updates (better screen redraw)
	endif
endif

if has('nvim')
	let g:python_host_prog  = '/usr/bin/python'
	let g:python3_host_prog = '/usr/bin/python3'
endif
"}}}
"------- Appearance: Colorscheme {{{
"-------------------------------------------------------------------------------
set t_Co=256            " Enable 256 color terminal
let g:rehash256 = 1     " Emulate 256 colors as close as possible if support is lacking

" Molokai colorscheme
let s:molokai_original = 1
colorscheme molokai

if has('nvim')
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Enables 24-bit RGB color in the TUI
if has('termguicolors')
	if exists('$TMUX')
		set termguicolors
	endif
endif
"}}}
"------- Appearance: Diff mode {{{
"-------------------------------------------------------------------------------

" Colorscheme for calling vimdiff from inside vim
autocmd FilterWritePre * if &diff | colorscheme hybrid | endif

" If we are in diff mode
if &diff
	set diffopt+=iwhite     " Ignore whitespace
	set diffopt+=vertical   " Vertical windows for diff
	set diffexpr=DiffW()    " Diff command
	colorscheme hybrid      " Use different colorscheme
	set nobackup
	set nowritebackup
	set noswapfile
endif
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
"}}}
"------- Appearance: Folding {{{
"-------------------------------------------------------------------------------
" fold color
hi Folded     cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none
"}}}
"------- Appearance: Line numbers {{{
"-------------------------------------------------------------------------------
set number                      " show line numbers
"set numberwidth=5              " reserve 5 Spaces for the numbering (left)
"}}}
"------- Appearance: Statusbar {{{
"-------------------------------------------------------------------------------
set showmode                    " Show INSERT, REPLACE or VISUAL in Statusbar
set ruler                       " Show line and column number
set laststatus=2                " Always show status line
set cmdheight=1

" Define colors
hi User1 guifg=#ffdad8  guibg=#880c0e           ctermfg=15 ctermbg=52
hi User2 guifg=#000000  guibg=#F4905C           ctermfg=16 ctermbg=166
hi User3 guifg=#292b00  guibg=#f4f597           ctermfg=16 ctermbg=192
hi User4 guifg=#112605  guibg=#aefe7B           ctermfg=16 ctermbg=84
hi User5 guifg=#051d00  guibg=#7dcc7d           ctermfg=16 ctermbg=72
hi User7 guifg=#ffffff  guibg=#880c0e gui=bold  ctermfg=15 ctermbg=52 cterm=bold
hi User8 guifg=#ffffff  guibg=#5b7fbb           ctermfg=15 ctermbg=13
hi User9 guifg=#ffffff  guibg=#810085           ctermfg=15 ctermbg=90
hi User0 guifg=#ffffff  guibg=#094afe           ctermfg=15 ctermbg=16

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
set statusline+=%7*\[%n]                                  " buffernr
set statusline+=%1*\ %<%F\                                " File+path
set statusline+=%2*\ %y\                                  " FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      " Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            " Encoding2
set statusline+=%4*\ %{&ff}\                              " FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  " Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             " Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            " Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      " Modified? Readonly? Top/bot
"}}}
"------- Appearance: Whitespace {{{
" Toggle whitespace characters on
set list

" Specify which list characters to show and what symbol to use
set listchars=tab:→\ ,space:·,eol:↵,trail:·,extends:↷,precedes:↶

" make the highlighting of tabs less annoying
"highlight SpecialKey ctermbg=235
"highlight NonText    ctermbg=235

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
set fillchars+=vert:│           " better looking for windows separator
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
"set clipboard^=unnamed,unnamedplus
if has('clipboard')
	"set clipboard& clipboard+=unnamedplus
	set clipboard^=unnamed,unnamedplus
endif
"}}}
"------- Behavior: Window Split {{{
"-------------------------------------------------------------------------------
set splitright                  " Split right instead of left
set splitbelow                  " Split below instead of above
"}}}
"------- Behavior: Folding {{{
"-------------------------------------------------------------------------------
" enable folding; http://vim.wikia.com/wiki/Folding
set foldmethod=marker           " fold based on marker
"set foldmethod=syntax          " fold based on indent
"
set foldnestmax=5               " deepest fold is 10 levels
"set nofoldenable               " don't fold by default
"set foldlevel=1
"}}}
"------- Behavior: Line wrapping {{{
"-------------------------------------------------------------------------------
set wrap                        " Wrap and display on next line if line is longer than window
set linebreak                   " Set soft wrapping (do not break words in between)

" Show colum separator to know how many characters to type per line
if exists('+colorcolumn')
	set colorcolumn=100
endif
"}}}
"------- Behavior: Mouse {{{
"-------------------------------------------------------------------------------
if has('mouse')
	set mouse=a             " Always use mouse
endif
"}}}
"------- Behavior: Scrolling {{{
"-------------------------------------------------------------------------------
set scrolloff=3                 " 3 lines above/below cursor when scrolling
"}}}
"------- Behavior: Searching {{{
"-------------------------------------------------------------------------------
set noignorecase                " Case-sensitive search (instead of ignorecase)
set smartcase                   " Keep case when searching with *
set magic                       " change the way backslashes are used in search patterns
set incsearch                   " Show search pattern while typing
set hlsearch                    " Highlight the search
"}}}
"------- Behavior: Bell {{{
"-------------------------------------------------------------------------------
set errorbells                  " Trigger bell on error
set visualbell                  " Use visual bell instead of beeping
"}}}
"------- Behavior: Autocomplete {{{
"-------------------------------------------------------------------------------
" Vim Omni completion.
" Ctrl+X Ctrl+O    Omni completion
" Ctrl+X Ctrl+F    Filename completion
" Ctrl+X Ctrl+P    Keywords in current file (backwords in file)
" Ctrl+X Ctrl+N    Keywords in current filea (forward in file)
" Ctrl+P           Keywords in 'complete' (backwards in file)
" Ctrl+N           Keywords in 'complete' (forward in file)

"autocmd FileType c              setlocal omnifunc=ccomplete#Complete
"autocmd FileType css            setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript     setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
"autocmd FileType python         setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType ruby,eruby     setlocal omnifunc=rubycomplete#Complete
"autocmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType sql            setlocal omnifunc=sqlcomplete#Complete

"set completeopt=menuone,menu             " Show menu by default
"set completeopt=longest,menuone,preview  " Show menu and preview window on top
"set completeopt=menuone,menu,longest      " Show menu and insert longest
"}}}
"------- Behavior: Wildmenu {{{
"-------------------------------------------------------------------------------
if has('wildmenu')
	set nowildmenu
	"set wildmode=list:longest,full
	set wildmode=longest,list
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
	set wildignore+=__pycache__,*.egg-info,.pytest_cache
endif
"}}}
"------- Behavior: Netrw {{{
"-------------------------------------------------------------------------------
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4

" Open Netrw without having to Type <CR> after the command
cnoreabbrev Ex       Explore<CR>
cnoreabbrev Exp      Explore<CR>
cnoreabbrev Expl     Explore<CR>
cnoreabbrev Explo    Explore<CR>
cnoreabbrev Explor   Explore<CR>
cnoreabbrev Explore  Explore<CR>
cnoreabbrev Ve       Vexplore<CR>
cnoreabbrev Vex      Vexplore<CR>
cnoreabbrev Vexp     Vexplore<CR>
cnoreabbrev Vexpl    Vexplore<CR>
cnoreabbrev Vexplo   Vexplore<CR>
cnoreabbrev Vexplor  Vexplore<CR>
cnoreabbrev Vexplore Vexplore<CR>
cnoreabbrev Se       Sexplore<CR>
cnoreabbrev Sex      Sexplore<CR>
cnoreabbrev Sexp     Sexplore<CR>
cnoreabbrev Sexpl    Sexplore<CR>
cnoreabbrev Sexplo   Sexplore<CR>
cnoreabbrev Sexplor  Sexplore<CR>
cnoreabbrev Sexplore Sexplore<CR>
"}}}
"------- Behavior: File detection {{{
"-------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *i3/config setfiletype i3config
autocmd BufNewFile,BufRead *.cnf setfiletype dosini
"}}}
"------- Editing: Encoding {{{
"-------------------------------------------------------------------------------
if has('vim_starting')
	set encoding=utf-8
	scriptencoding utf-8
endif
"}}}
"------- Editing: Indentation {{{
"-------------------------------------------------------------------------------
set autoindent                  " Copy the indentation from the previous line
set smartindent                 " Do not smart intend
"}}}
"------- Editing: Line feeds {{{
"-------------------------------------------------------------------------------
set fileformat=unix             " Default fileformat.
set fileformats=unix,dos,mac    " Automatic recognition of a new line cord.
"}}}
"------- Editing: Tabs vs Spaces {{{
"-------------------------------------------------------------------------------
set noexpandtab                 " Insert tabs rather than spaces for <TAB>
set smarttab                    " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4                   " Number of spaces a tab counts for
set softtabstop=4               " Edit as if the tabs are 4 characters wide
set shiftwidth=4                " Number of spaces to use for indent and unindent
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
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

" Resize the divisions if the Vim window size changes
au VimResized * exe "normal! \<c-w>="

"nnoremap <F10> :!open % -a Google\ Chrome<CR>
nnoremap <F10> :!chromium %<CR>

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
"------- Plugin: FZF {{{
"-------------------------------------------------------------------------------
" Keybindings
nnoremap <C-p> :Files<CR>
nnoremap <C-o> :Buffers<CR>
nnoremap <C-g> :Ag<CR>
nnoremap <C-f> :Lines<CR>

" Keybindungs while fzf is active
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-x': 'split',
	\ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = {'down': '~30%'}

"""
""" Alternative with floating window
"""
"autocmd! FileType fzf
"autocmd  FileType fzf set laststatus=0 noshowmode noruler
"  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"let $FZF_DEFAULT_OPTS='--layout=reverse'
"let g:fzf_layout = { 'window': 'call FloatingFZF()' }
"function! FloatingFZF()
"  let buf = nvim_create_buf(v:false, v:true)
"  call setbufvar(buf, '&signcolumn', 'no')
"
"  let height = &lines - 8
"  let width = float2nr(&columns - (&columns * 2 / 10))
"  let col = float2nr((&columns - width) / 2)
"
"  let opts = {
"        \ 'relative': 'editor',
"        \ 'row': 4,
"        \ 'col': col,
"        \ 'width': width,
"        \ 'height': height
"        \ }
"
"  "call nvim_open_win(buf, v:true, opts)
"
"  let win = nvim_open_win(buf, v:true, opts)
"  call setwinvar(win, '&number', 0)
"endfunction
"highlight NormalFloat cterm=NONE ctermfg=14 ctermbg=0 gui=NONE guifg=#93a1a1 guibg=#00FF00


" Customize fzf colors to match your color scheme
let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
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
	\ 'header':  ['fg', 'Comment']
	\ }

" [Files] Extra options for fzf
"   e.g. File preview using Highlight
"   (http://www.andre-simon.de/doku/highlight/en/highlight.html)
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
"}}}
"------- Plugin: NerdTree {{{
"-------------------------------------------------------------------------------
" Key mappings
map <C-n> :NERDTreeToggle<CR>

" Options
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=0

" Change current working directory accordingly when loading bookmarks
let NERDTreeChDirMode=2

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NerdTree colors
hi Directory guifg=#7F7F84 ctermfg=red
"}}}
"------- Plugin: NerdTree Git {{{
"-------------------------------------------------------------------------------

"let g:NERDTreeIndicatorMapCustom = {
"	\ "Modified"  : "✹",
"	\ "Staged"    : "✚",
"	\ "Untracked" : "✭",
"	\ "Renamed"   : "➜",
"	\ "Unmerged"  : "═",
"	\ "Deleted"   : "✖",
"	\ "Dirty"     : "✗",
"	\ "Clean"     : "✔︎",
"	\ 'Ignored'   : '☒',
"	\ "Unknown"   : "?"
"	\ }
"}}}
"------- Plugin: Tagbar {{{
"-------------------------------------------------------------------------------
nmap <leader>t :TagbarToggle<CR>
"}}}
"------- Plugin: Vista tags {{{
"-------------------------------------------------------------------------------
"noremap <leader>s :Vista finder coc<CR>
"nnoremap <C-x> :Vista finder coc<CR>
"let g:vista_default_executive = 'coc'
"let g:vista_fzf_preview = ['right:50%']
"let g:vista_disable_statusline =1
"let g:vista_executive_for = {
"	\ 'cpp': 'vim_lsp',
"	\ 'php': 'vim_lsp',
"	\ 'markdown': 'toc',
"	\ }
"}}}
"------- Plugin: Signify {{{
"-------------------------------------------------------------------------------
" See molokai colorscheme for SignColumn Backgroun to adjust the background
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change

let g:signify_sign_show_count = 1

highlight SignifySignAdd    ctermbg=235 guifg=#00FF00 guibg=#232526
highlight SignifySignDelete ctermbg=235 guifg=#FF0000 guibg=#232526
highlight SignifySignChange ctermbg=235 guifg=#F68A2B guibg=#232526

nnoremap <leader>gp :SignifyHunkDiff<cr>
"}}}
"------- Plugin: Coc {{{
"-------------------------------------------------------------------------------

" Initialize Coc settings when it is loaded
function InitializeCoc()
	set hidden            " If hidden is not set, TextEdit might fail.

	set nobackup          " Some servers have issues with backup files, see #649
	set nowritebackup     " Some servers have issues with backup files, see #649

	set updatetime=300    " Default is 4000 which is too slow
	set shortmess+=c      " Don't give |ins-completion-menu| messages.

	" Highlight symbol under cursor on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Use <TAB> for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	" Use <C-SPACE> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>
endfunction

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
"}}}
" HELP
"-------------------------------------------------------------------------------
" :so %			   " Reload vimrc from vimrc
" :so $MYVIMRC     " Reload vimrc form any other file

" let              " assigns value to variable
" set              " assigns value to vim's internal option

" g:               " global var, accessible anywhere
" s:               " script local variable, accessible anywhere in given script
" l:               " function local variable
" a:               " function argument
"
" function foo()   " Errors if function name already exists
" function! foo()  " ! overwrites an existing function silently
" function s:foo() " Function only known in this script

" call func()      " Call globally defined function
" <SID>func()      " Call s:func defined function (script local) :help <SID>

" echo var         " Echo variable
" echo &opt        " Echo vim's internal option (which was assigned via set)

" map A B          " Map recursive (all modes) - By pressing 'A' execute what B is set to
" nmap             " Map recursive (normal mode)
" vmap             " Map recursive (visual mode)

" noremap A B      " Map non-recursive (all modes) - By pressing 'A' execute 'B'
" nnoremap         " Map non-recursive (normal mode)
" vnoremap         " Map non-recursive (visual mode)

" vim: set ts=4:
