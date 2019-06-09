" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" USER SETTINGS
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
call plug#end()

" Directory browsing
let g:netrw_winsize = 25
let g:netrw_banner=1 "No header spam in directory mode
let g:netrw_liststyle=3 "Tree style
let g:netrw_browse_split=2

" Typescript
let g:typescript_compiler_binary='./node_modules/.bin/tsc'
" let g:typescript_compiler_options

autocmd QuickFixCmdPost [^1]* nested cwindow " Shows quicklist after :make
autocmd QuickFixCmdPost 1* nested lwindow

set path=**
set shell=/usr/bin/zsh

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildignore+=**/node_modules/**

" Identing
set tabstop=4
set shiftwidth=4
set expandtab

set history=1000

" Line numbers
" set number
" set number!
" set relativenumber

set nowrap
set ruler

" Backup / Swap files
set backupdir-=.
set backupdir^=$HOME/tmp,/tmp
set undodir^=$HOME/tmp,/tmp
set noswapfile

" Keymaps
let mapleader=" " 

" Training not to use arrow keys or h, j, k, l for navigation 
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap k <NOP>
noremap j <NOP>
noremap h <Left> <NOP>
noremap l <Right> <NOP>
