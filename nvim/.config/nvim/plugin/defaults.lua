local Remap = require("hendrik.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local nmap = Remap.nmap

-- Save on typo
-- command! W w

-- Auto brackets
inoremap('<<', '<><ESC>i')
inoremap('((', '()<ESC>i')
inoremap('[[', '[]<ESC>i')
inoremap('{{', '{}<ESC>i')
inoremap('""', '""<ESC>i')
inoremap("''", "''<ESC>i")
inoremap('``', '``<ESC>i')

-- Break habits
inoremap("<Up>", '<C-o>:echom "--> k <-- "<CR>')
inoremap("<Down>", '<C-o>:echom "--> j <-- "<CR>')
inoremap("<Right>", '<C-o>:echom "--> l <-- "<CR>')
inoremap("<Left>", '<C-o>:echom "--> h <-- "<CR>')

-- vim.api.nvim_command("cabbrev wq echo 'Use ZZ'")
-- vim.api.nvim_command("cabbrev q echo 'Use ZQ'")
-- vim.api.nvim_command("cabbrev x echo 'Use ZZ'")
-- TODO: what does <C-x> do?

-- Save
-- nnoremap("<C-s>", ":w<CR>")

-- Autocompletion
-- inoremap <C-S> <cmd>lua require('cmp').complete()<cr>

-- TODO: Check this! Tab hasn't a function here
-- imap <expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- inoremap  <S-Tab> <cmd>lua require'luasnip'.jump(-1)<cr>
--
-- snoremap  <Tab> <cmd>lua require('luasnip').jump(1)<cr>
-- snoremap  <S-Tab> <cmd>lua require('luasnip').jump(-1)<cr>
--
-- imap <expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'
-- smap <expr> <C-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-e>'


-- Remapping navigation to be friendlier with Dvorak
-- nnoremap("d","h")
-- nnoremap("h","j")
-- nnoremap("t","k")
-- nnoremap("n","l")
-- nnoremap("ee","dd")
-- nnoremap("y","t")
-- nnoremap("Y","T")
-- nnoremap("e","d")

-- Remapping b --> n in normal mode (for navigation in search)
-- nnoremap("b","n")
-- nnoremap("B","N")

-- Remapping window navigation
-- nnoremap("<","-Right> <C-W>l")
-- nnoremap("<","-Left> <C-W>h")
-- nnoremap("<","-Down> <C-W>j")
-- nnoremap("<","-Up> <C-W>k")

-- Easier command typing for Dvorak
-- nnoremap(";", ":")
-- nnoremap(":", ";")

-- Tame Yank!
nnoremap("Y", "yg$")

-- Center everything
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("]n", "<Plug>(unimpaired-context-next)zz")
nnoremap("[n", "<Plug>(unimpaired-context-previous)zz")
--nnoremap("J", "mzJ`z")

-- Source file
nnoremap("<leader>s", ":so %<CR>")

-- Reload config
nnoremap("<leader><CR>", ":so $XDG_CONFIG_HOME/nvim/init.vim<CR>")
nnoremap("<leader>r", function()
    return require('plenary.reload').reload_module('hendrik', true)
end)
nnoremap("<leader>o", ":SymbolsOutline<CR>")

nnoremap("<C-f>", ":silent !tmux neww tmux-sessionizer<CR>")

-- Next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "+y")
vnoremap("<leader>y", "+y")
nmap("<leader>Y", "+Y")

-- Turn hlsearch off after search
nnoremap("<expr>", '<CR> {-> v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()')

-- Delete forwards
inoremap("<C-s>", "<C-o>de")

-- Telescope
nnoremap("<leader>ff", function()
    return require('telescope.builtin').find_files({ hidden = true, no_ignore = true })
end)

nnoremap("<leader>fg", function()
    return require('telescope.builtin').live_grep()
end)

nnoremap("<leader>fb", function()
    return require('telescope.builtin').buffers()
end)

nnoremap("<leader>fh", function()
    return require("telescope.builtin").help_tags()
end)

nnoremap("<leader>m", function()
    return require("telescope.builtin").filetypes()
end)

nnoremap("<leader>ds", function()
    return require("telescope.builtin").lsp_document_symbols()
end)

-- Telescope: git_worktree
nnoremap("<leader>gw", function()
    return require("telescope").extensions.git_worktree.git_worktrees()
end)

nnoremap("<leader>gm", function()
    return require("telescope").extensions.git_worktree.create_git_worktree()
end)

-- Telescope: custom
nnoremap("<leader>dot", function()
    return require('hendrik.telescope').search_dotfiles()
end)

nnoremap("<leader>lsp", ":e $DOTFILES/nvim/.config/nvim/after/plugin/lsp.lua<CR>")

nnoremap("<C-p>", function()
    return require('hendrik.telescope').project_files()
end)

nnoremap("<leader>gh", function()
    return require("telescope.builtin").git_bcommits()
end)

-- Nvim-tree
nnoremap("<C-b>", function()
    return require('hendrik.nvim-tree').toggle_focused_file()
end)

-- SymbolsOutline
nnoremap("<leader>o", ":SymbolsOutline<cr>")

-- Harpoon
nnoremap("<leader>a", function()
    require("harpoon.mark").add_file()
end)

nnoremap("<C-e>", function()
    require("harpoon.ui").toggle_quick_menu()
end)

nnoremap("<C-j>", function()
    require("harpoon.ui").nav_file(1)
end)

nnoremap("<C-k>", function()
    require("harpoon.ui").nav_file(2)
end)

nnoremap("<C-l>", function()
    require("harpoon.ui").nav_file(3)
end)
