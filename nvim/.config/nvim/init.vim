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

" Learning motions
" Plug 'wikitopian/hardmode'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'nvim-lua/lsp_extensions.nvim'

" Statusline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'rafamadriz/friendly-snippets'

Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox

let mapleader = " "

:lua require("hendrik")

" Save on typo
command W w

" Save as root
nnoremap <leader>w <cmd>lua require('hendrik').sudo_write()<CR>
" command Sw lua require'hendrik'.sudo_write()

"Break habits
cabbrev wq echo "Use ZZ"
cabbrev q echo "Use ZQ"
cabbrev x echo "Use ZZ"

" Save
nnoremap <C-s> :w<CR>

" Move lines
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Tame Yank!
nnoremap Y yg$

" Center everything
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap <leader>s :so %<CR>

" Reload config
nnoremap <Leader><CR> :so $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Jump qlist
nnoremap <Leader>j :cnext<CR>
nnoremap <Leader>k :cprev<CR>

" Autocompletion
inoremap <C-S> <cmd>lua require('cmp').complete()<CR>

" TODO: Check this! Tab hasn't a function here
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<CR>
"
" snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<CR>
" snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<CR>
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
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter * :lua require'lsp_extensions'.inlay_hints{}
augroup END

" Hardmode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
