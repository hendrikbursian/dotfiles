vim.opt.encoding = 'utf8'

table.insert(vim.opt.path, '**')
vim.opt.guicursor = { 'n-v-c-sm:block', 'i-ci-ve:block', 'r-cr-o:hor20' }
-- vim.opt.shortmess:append({ A = true })
vim.opt.mouse = "a"

-- Disable notifications
vim.opt.belloff = "all"

-- Formatting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Backups
vim.opt.hidden = true
vim.opt.swapfile = true
vim.opt.directory = os.getenv('XDG_CONFIG_HOME') .. '/nvim/swap//'
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.backupdir = os.getenv('XDG_CONFIG_HOME') .. '/nvim/backup//'
vim.opt.undofile = true
vim.opt.undodir = os.getenv('XDG_CONFIG_HOME') .. '/nvim/undo//'

-- Seaching
vim.opt.hlsearch = false
vim.opt.ignorecase = true
-- vim.opt.smartcase = true
vim.opt.incsearch = true

-- Misc
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.breakindentopt = "sbr"
vim.opt.showbreak = "↪  \\"
vim.opt.sidescroll = 20
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = { 80, 120 }
vim.opt.updatetime = 50

-- TODO: Add when https://github.com/neovim/neovim/pull/18961 is fixed
vim.opt.cmdheight = 0

-- Nice menu when typing `:find *.py`
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true
vim.opt.wildignore = { '*.pyc', '*_build/*', '**/coverage/*', '**/node_modules/*', '**/android/*', '**/ios/*',
    '**/.git/*' }

vim.g.neoformat_try_node_exe = true


-- LSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }
