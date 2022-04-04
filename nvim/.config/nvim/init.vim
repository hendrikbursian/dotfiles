" Autoinstall vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" File tree
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" Learning motions
" Plug 'wikitopian/hardmode'
Plug 'tpope/vim-surround'

" Autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

" Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'

" Formatting
Plug 'gpanders/editorconfig.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'rafamadriz/friendly-snippets'

Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox

let mapleader = " "

lua require("hendrik")

lua require('nvim-treesitter.configs').setup({ highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }, })

" Save on typo
command! W w

" Save as root
nnoremap <leader>w <cmd>lua require('hendrik').sudo_write()<cr>
" command Sw lua require'hendrik'.sudo_write()

"Break habits
cabbrev wq echo "Use ZZ"
cabbrev q echo "Use ZQ"
cabbrev x echo "Use ZZ"

" Save
" nnoremap <C-s> :w<cr>

" Move lines
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

" Tame Yank!
nnoremap Y yg$

" Center everything
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Source file
nnoremap <leader>s :so %<cr>

" Reload config
nnoremap <leader><cr> :so $XDG_CONFIG_HOME/nvim/init.vim<cr>
nnoremap <leader>r <cmd>:lua require('plenary.reload').reload_module('hendrik', true)<cr>

" Jump qlist
nnoremap <leader>j :silent cnext<cr>
nnoremap <leader>k :silent cprev<cr>

nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<cr>

" Autocompletion
" inoremap <C-S> <cmd>lua require('cmp').complete()<cr>

" TODO: Check this! Tab hasn't a function here
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<cr>
"
" snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<cr>
" snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>
"
" imap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
" smap <silent><expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'

" Auto brackets
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
inoremap `` ``<Esc>i

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

augroup HENDRIK
    autocmd!
    " autocmd BufWritePre *.lua Neoformat
    " autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_seq_sync({}, 1000, {'eslint', 'tsserver', 'rome'})
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter * :lua require('lsp_extensions').inlay_hints{}
augroup END

" Hardmode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
