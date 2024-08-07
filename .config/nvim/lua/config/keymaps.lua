local Util = require("lazyvim.util")

-- Disable <leader> only
vim.keymap.set({ "n", "v" }, "<leader>", "<Nop>", { silent = true })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Y", "y$", { desc = "Tame yank!" })

-- Make yank work with cursor=virtual
vim.keymap.set("n", "yy", "my0yy`y<CMD>delmark y<CR>")
-- TODO: check this
vim.keymap.set("v", "y", "my0y`y<CMD>delmark y<CR>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Center everything
vim.keymap.set("n", "{", "{zz", { desc = "Move paragraph up" })
vim.keymap.set("n", "}", "}zz", { desc = "Move paragraph down" })
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Jump to previous position" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Jump to next position" })
--vim.keymap.set("n","J", "mzJ`z")
vim.keymap.set("n", "gX", ":!xdg-open %:h<cr>", { desc = "Open directory of current file" })

-- Diagnostic
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Open Diagnostic floating window" })
vim.keymap.set("n", "<leader>vq", vim.diagnostic.setloclist, { desc = "Add Diagnostics to local quickfix list" })

vim.keymap.set("n", "<leader>S", ":so %<CR>", { desc = "Source current file" })
-- stylua: ignore
vim.keymap.set("n", "<leader>r", function() require("plenary.reload").reload_module("module", true) end, { desc = "Reload config" })

-- Timesheet
-- vim.keymap.set("n", "<Leader>t", ":e $HOME/Documents/Freelancing/timesheet.txt<CR>", { desc = "Open Timesheet" })

-- stylua: ignore
vim.keymap.set("n", "<C-f>", ":silent !tmux neww -e SESSION_DIRS=$SESSION_DIRS tmux-sessionizer<CR>", { desc = "Sezzzionizezzer" })
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without copying!" })
vim.keymap.set("n", "<C-s>", "<cmd>write<cr>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<C-o>", { desc = "Delete forwards" })

vim.keymap.set("n", "<leader>x", ":!chmod +x %<CR>", { silent = true, desc = "Give executable permission" })
vim.keymap.set("n", "<leader>X", ":!chmod -x %<CR>", { silent = true, desc = "Remove executable permission" })

-- Resizing (Source: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/buffer-resize.lua)
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { silent = true, desc = "Expand buffer vertically" })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { silent = true, desc = "Shrink buffer vertically" })
vim.keymap.set("n", "<Left>", ":vert resize -5<cr>", { silent = true, desc = "Shrink buffer horizontally" })
vim.keymap.set("n", "<Right>", ":vert resize +5<cr>", { silent = true, desc = "Expand buffer horizontally" })

 -- stylua: ignore start

-- Toggle  Quickfixlist
vim.keymap.set("n", "<leader>Q", function() require("modules.ui").toggle_qf_list(true) end, { noremap = true, silent = true, desc = "Toggle global quickfix list" })
vim.keymap.set("n", "<leader>q", function() require("modules.ui").toggle_qf_list(false) end, { noremap = true, silent = true, desc = "Toggle local quickfix list" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
vim.keymap.set("n", "<leader>gG", function() Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (cwd)" })

--stylua: ignore end
