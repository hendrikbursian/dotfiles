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
vim.keymap.set("n", "]n", "<Plug>(unimpaired-context-next)zz")
vim.keymap.set("n", "[n", "<Plug>(unimpaired-context-previous)zz")
vim.keymap.set("n", "<Plug>(slash-after)", "zz")
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
vim.keymap.set("n", "<Leader>t", ":e $HOME/Documents/Freelancing/timesheet.txt<CR>")

-- Sezzzionizezzer
vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")

-- Delete without copying!
vim.keymap.set("n", "<leader>d", "\"_d")

-- Delete forwards
vim.keymap.set("i", "<C-s>", "<C-o>de")

-- Telescope
vim.keymap.set("n", "<C-p>", require("hendrik.telescope").git_files)
vim.keymap.set("n", "<leader>dot", require("hendrik.telescope").search_dotfiles)
vim.keymap.set("n", "<leader>ff", require("hendrik.telescope").find_files)
vim.keymap.set("n", "<leader>fc", require("hendrik.telescope").grep_clipboard)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fs", require("telescope.builtin").grep_string)
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<leader>m", require("telescope.builtin").filetypes)
vim.keymap.set("n", "<leader>gh", require("telescope.builtin").git_bcommits)
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics)

vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end)

-- Telescope: git_worktree
vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<leader>gm", require("telescope").extensions.git_worktree.create_git_worktree)

-- Shortcuts
vim.keymap.set("n", "<leader>lsp", ":e $DOTFILES/nvim/.config/nvim/after/plugin/lsp.lua<CR>")

-- Nvim tree
vim.keymap.set("n", "<C-b>", require("hendrik.nvim-tree").toggle_focused_file)

-- SymbolsOutline
vim.keymap.set("n", "<leader>o", ":SymbolsOutline<cr>")

-- Harpoon
vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
vim.keymap.set("n", "<C-j>", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<C-k>", function() require("harpoon.ui").nav_file(2) end)

-- Neotest
vim.keymap.set("n", "<leader>tt", function() require("neotest").run.run() end)
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.api.nvim_buf_get_name(0)) end)
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end)
vim.keymap.set("n", "<leader>tl", function() require("neotest").run.run_last() end)
vim.keymap.set("n", "<leader>te", function() require("neotest").summary.toggle() end, { desc = "[T]est [E]xplorer" })

-- Breakpoints
vim.keymap.set("n", "<leader>bb", require("persistent-breakpoints.api").toggle_breakpoint)
vim.keymap.set("n", "<leader>bc", require("persistent-breakpoints.api").set_conditional_breakpoint)
vim.keymap.set("n", "<leader>bD", require("persistent-breakpoints.api").clear_all_breakpoints)

-- Make executable
vim.keymap.set("n", "<leader>x", "!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>X", "!chmod -x %<CR>", { silent = true })

-- Resizing (Source: https://github.com/ldelossa/dotfiles/blob/master/config/nvim/lua/configs/buffer-resize.lua)
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { silent = true })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Left>", ":vert resize -5<cr>", { silent = true })
vim.keymap.set("n", "<Right>", ":vert resize +5<cr>", { silent = true })

-- DAP
vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F12>", function() require("dap").repl.toggle() end)

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
