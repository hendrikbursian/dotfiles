local Util = require("lazyvim.util")

-- Tame Yank!
vim.keymap.set("n", "Y", "yg$")

-- Disable <leader> only
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Make yank work with cursor=virtual
vim.keymap.set("n", "yy", "my0yy`y<CMD>delmark y<CR>")
-- TODO: check this
vim.keymap.set("v", "y", "my0y`y<CMD>delmark y<CR>")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center everything
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
--vim.keymap.set("n","J", "mzJ`z")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>vq", vim.diagnostic.setloclist)

-- Source file
vim.keymap.set("n", "<leader>s", ":so %<CR>")

-- Reload config
vim.keymap.set("n", "<leader>r", function() require("plenary.reload").reload_module("hendrik", true) end)

-- Timesheet
-- vim.keymap.set("n", "<Leader>t", ":e $HOME/Documents/Freelancing/timesheet.txt<CR>")

-- Sezzzionizezzer
vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")

-- Delete without copying!
vim.keymap.set("n", "<leader>d", "\"_d")

-- Delete forwards
vim.keymap.set("i", "<C-s>", "<C-o>de")

-- Shortcuts
vim.keymap.set("n", "<leader>lsp", ":e $DOTFILES/nvim/.config/nvim/after/plugin/lsp.lua<CR>")

-- Make executable
vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>X", ":!chmod -x %<CR>", { silent = true })

-- Resizing (Source: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/buffer-resize.lua)
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { silent = true })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Left>", ":vert resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Right>", ":vert resize +5<cr>", { silent = true })

-- Cycle colorschemes
vim.keymap.set("n", "<leader>c", function() require("hendrik.colorscheme").next() end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>C", function() require("hendrik.colorscheme").prev() end, { noremap = true, silent = true })

-- Toggle qickfixlist
vim.keymap.set("n", "<C-q>", function() require("ui").toggle_qf_list(false) end, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", function() require("ui").toggle_qf_list(true) end, { noremap = true, silent = true })

-- lazygit
vim.keymap.set("n", "<leader>gg",
    function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end,
    { desc = "Lazygit (root dir)" })
vim.keymap.set("n", "<leader>gG", function() Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end,
    { desc = "Lazygit (cwd)" })
