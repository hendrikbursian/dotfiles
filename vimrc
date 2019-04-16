" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  $HOME/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

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
syntax on

set path=**

" Searching
set hlsearch
set incsearch

" Identing
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on

set history=1000

set shell=/usr/bin/zsh

let g:netrw_banner=1 "No header spam in directory mode

let g:netrw_liststyle=3 "Tree style

let g:netrw_browse_split=2

" Line numbers
set number
set number!
set relativenumber

set nowrap

" Backup / Swap files
set backupdir-=.
set backupdir^=$HOME/tmp,/tmp
set undodir^=$HOME/tmp,/tmp
set noswapfile
set ruler
