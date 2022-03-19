set encoding=utf8

set path+=**

" Source successive config files for overriding
set exrc

" Disable notifications
set noerrorbells

" Formatting
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

" Line numbers
set relativenumber
set number

" Backups
set hidden
set noswapfile
set nobackup
set undodir=$XDG_CONFIG_HOME/nvim/undo
set undofile

" Seaching
set hlsearch
set ignorecase
" set smartcase
set incsearch

" Misc
set nowrap
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set updatetime=50
set termguicolors
set completeopt=menuone,noinsert,noselect

" Nice menu when typing `:find *.py`
set wildmode=longest,list,full
set wildmenu

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" Autoinstall vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'neovim/nvim-lspconfig'

Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox

let mapleader = " "

command W w

nnoremap <Esc> :nohl<CR>
nnoremap <C-s> :w<CR>

nnoremap <Leader><CR> :so $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Trim trailing whitespace on write
autocmd BufWritePre * :%s/\s\+$//e

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
