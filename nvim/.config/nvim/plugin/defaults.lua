-- Tame Yank!
vim.keymap.set("n", "Y", "yg$")

-- Make yank work with cursor=virtual
vim.keymap.set("n", "yy", "my0yy`y<CMD>delmark y<CR>")
-- TODO: check this
vim.keymap.set("v", "y", "my0y`y<CMD>delmark y<CR>")

-- Center everything
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "]n", "<Plug>(unimpaired-context-next)zz")
vim.keymap.set("n", "[n", "<Plug>(unimpaired-context-previous)zz")
--vim.keymap.set("n","J", "mzJ`z")

-- Source file
vim.keymap.set("n", "<leader>s", ":so %<CR>")

-- Reload config
vim.keymap.set("n", "<leader>r", function()
    return require('plenary.reload').reload_module('hendrik', true)
end)

-- Timesheet
vim.keymap.set("n", "<Leader>t", ":e $HOME/Documents/Freelancing/timesheet.txt<CR>")

-- Sezzzionizezzer
vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")

-- Delete without copying!
vim.keymap.set("n", "<leader>d", "\"_d")

-- Delete forwards
vim.keymap.set("i", "<C-s>", "<C-o>de")

-- Telescope
vim.keymap.set("n", "<leader>ff", function()
    return require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end)

vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep)
vim.keymap.set("n", "<leader>fc", require("hendrik.telescope").grep_clipboard)
vim.keymap.set("n", "<leader>fs", require('telescope.builtin').grep_string)

-- TODO: Use selection for grep
-- vim.keymap.set("v","<leader>fs", function()
--     local s = vim.fn.getpos("'<")
--     local e = vim.fn.getpos("'>")

--     P(s)
--     local line_start = s[2]
--     local line_end = e[2]
--     P(line_start)
--     P(line_end)
--     -- local start_col = s[1]

--     -- local end_col = end[1]

--     vim.fn.getline(line_start, line_end)

--     -- return require('telescope.builtin').grep_string()
-- end)

vim.keymap.set("n", "<leader>fb", function()
    return require('telescope.builtin').buffers()
end)

vim.keymap.set("n", "<leader>fh", function()
    return require("telescope.builtin").help_tags()
end)

vim.keymap.set("n", "<leader>m", function()
    return require("telescope.builtin").filetypes()
end)

vim.keymap.set("n", "<leader>ds", function()
    return require("telescope.builtin").lsp_document_symbols()
end)

-- Telescope: git_worktree
vim.keymap.set("n", "<leader>gw", function()
    return require("telescope").extensions.git_worktree.git_worktrees()
end)

vim.keymap.set("n", "<leader>gm", function()
    return require("telescope").extensions.git_worktree.create_git_worktree()
end)

-- Telescope: custom
vim.keymap.set("n", "<leader>dot", function()
    return require('hendrik.telescope').search_dotfiles()
end)

vim.keymap.set("n", "<leader>lsp", ":e $DOTFILES/nvim/.config/nvim/after/plugin/lsp.lua<CR>")

vim.keymap.set("n", "<C-p>", function()
    return require('hendrik.telescope').project_files()
end)

vim.keymap.set("n", "<leader>gh", function()
    return require("telescope.builtin").git_bcommits()
end)

-- Nvim-tree
vim.keymap.set("n", "<C-b>", function()
    return require('hendrik.nvim-tree').toggle_focused_file()
end)

-- SymbolsOutline
vim.keymap.set("n", "<leader>o", ":SymbolsOutline<cr>")

-- Harpoon
vim.keymap.set("n", "<leader>a", function()
    require("harpoon.mark").add_file()
end)

vim.keymap.set("n", "<C-e>", function()
    require("harpoon.ui").toggle_quick_menu()
end)

vim.keymap.set("n", "<C-j>", function()
    require("harpoon.ui").nav_file(1)
end)

vim.keymap.set("n", "<C-k>", function()
    require("harpoon.ui").nav_file(2)
end)

-- Neotest
vim.keymap.set("n", '<leader>tt', function()
    require('neotest').run.run()
end)

vim.keymap.set("n", '<leader>tf', function()
    require('neotest').run.run(vim.api.nvim_buf_get_name(0))
end)

vim.keymap.set("n", '<leader>td', function()
    require('neotest').run.run({ strategy = 'dap' })
end)

vim.keymap.set("n", '<leader>tl', function()
    require('neotest').run.run_last()
end)

-- Mnemonic: [t]est [e]xplorer
vim.keymap.set("n", '<leader>te', function()
    require('neotest').summary.toggle()
end)

-- vim.keymap.set("n",'<leader>ta', function()
--     require('neotest').run.run()
-- end)

-- vim.keymap.set("n",'<leader>tl', function()
--     require('neotest').run.run()
-- end)

-- vim.keymap.set("n",'<leader>tv', function()
--     require('neotest').run.run()
-- end)

vim.keymap.set("n", '<leader>bb', function()
    require('persistent-breakpoints.api').toggle_breakpoint()
end)

vim.keymap.set("n", '<leader>bc', function()
    require('persistent-breakpoints.api').set_conditional_breakpoint()
end)

vim.keymap.set("n", '<leader>bD', require('persistent-breakpoints.api').clear_all_breakpoints)

vim.keymap.set("n", '<leader>x', '!chmod +x %<CR>', { silent = true })
vim.keymap.set("n", '<leader>X', '!chmod -x %<CR>', { silent = true })

-- Source: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/buffer-resize.lua
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { silent = true })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Left>", ":vert resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Right>", ":vert resize +5<cr>", { silent = true })

-- DAP
local dap = require("dap")

vim.keymap.set("n", '<F5>', dap.continue)
vim.keymap.set("n", '<F10>', dap.step_over)
vim.keymap.set("n", '<F11>', dap.step_into)
vim.keymap.set("n", '<F12>', dap.repl.toggle)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
