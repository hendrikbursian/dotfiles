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
set nohlsearch
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
