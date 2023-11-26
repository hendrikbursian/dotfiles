vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.path:append({ "**" })
-- vim.opt.shortmess:append({ A = true })
vim.opt.mouse = "a"
vim.opt.virtualedit = "all"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "line"
vim.opt.synmaxcol = 2000
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.foldlevelstart = 3
vim.opt.foldmethod = "indent"

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
vim.opt.swapfile = false
vim.opt.directory = os.getenv("XDG_CONFIG_HOME") .. "/nvim/swap//"
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.backupdir = os.getenv("XDG_CONFIG_HOME") .. "/nvim/backup//"
vim.opt.undofile = true
vim.opt.undodir = os.getenv("XDG_CONFIG_HOME") .. "/nvim/undo//"

-- Seaching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Misc
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.breakindentopt = "sbr"
vim.opt.showbreak = "↪  \\"
vim.opt.sidescroll = 20
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
-- vim.opt.colorcolumn = { 80, 120 }
vim.opt.updatetime = 250
-- vim.opt.updatetime = 50

-- vim.opt.cmdheight = 0

-- Nice menu when typing `:find *.py`
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildmenu = true
vim.opt.wildignore = {
	"*.pyc",
	"*_build/*",
	"**/coverage/*",
	"**/node_modules/*",
	"**/android/*",
	"**/ios/*",
	"**/.git/*",
}

-- LSP
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

vim.opt.synmaxcol = 200

-- Colorscheme
vim.opt.termguicolors = true

-- Cursor
vim.opt.guicursor = { "n-v-c-sm:block-Cursor", "i-ci-ve:block-Cursor", "r-cr-o:hor20" }
vim.opt.background = "light"
