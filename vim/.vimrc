" ### GENERAL ### 

set number
set relativenumber 
syntax enable

" Sane split orders
"set splitbelow
"set splitright


" Makes :find search recursively
"set autochdir
set path+=**
set path+=./..

set backspace=indent,eol,start
set complete-=i "Don't complete from include files
set completeopt+=longest "Don't auto select alternative in autocompletion

" Indentation 
set tabstop=8
set shiftwidth=1
set softtabstop=-1 "negative value means use shiftwidth
set noexpandtab
set smartindent
set autoindent
set smarttab

" Don't consider numbers beginning with 0 as octal
set nrformats-=octal 


" Needs vim to be built with clipboard access
set clipboard=unnamedplus

nnoremap "<C-d>" "<C-d>zz"
nnoremap "<C-u>" "<C-u>zz"

" Auto load views
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" Automatic VimPlug installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"dense-analysis/ale
"let g:ale_completion_enabled=1
let g:ale_python_pyls_executable="pylsp"
let g:ale_python_flake8_options="--ignore=E501"

" use ale for omnicompletion
set omnifunc=ale#completion#OmniFunc

call plug#begin()
Plug 'dense-analysis/ale'
call plug#end()

" ### VIM-SENSIBLE ### 
if has('autocmd')
	filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif

" Use :help 'option' to see the documentation for the given option.
if !has('nvim') && &ttimeoutlen == -1
	set ttimeout
	set ttimeoutlen=100
endif

set incsearch

set laststatus=2
set ruler
set wildmenu

if !&scrolloff
	set scrolloff=1
endif
if !&sidescrolloff
	set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
	set encoding=utf-8
endif

if &listchars ==# 'eol:$'
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
	set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
	setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$' && (v:version < 704 || v:version == 704 && !has('patch276'))
	set shell=/usr/bin/env\ bash
endif

set autoread

if &history < 1000
	set history=1000
endif
if &tabpagemax < 50
	set tabpagemax=50
endif
if !empty(&viminfo)
	set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
	set t_Co=16
endif

" ### END VIM-SENSIBLE ### 

" Stop annoying auto commenting
autocmd FileType * setlocal formatoptions-=r formatoptions-=o
