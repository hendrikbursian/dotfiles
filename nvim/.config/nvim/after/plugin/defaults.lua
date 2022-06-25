print "Loading defaults"

Nnoremap("<leader>ff", "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<cr>")
Nnoremap("<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
Nnoremap("<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")

Nnoremap("<leader>dot", "<cmd>lua require('telescope').search_dotfiles()<cr>")
Nnoremap("<C-p>", "<cmd>lua require('telescope').project_files()<cr>")

Nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")

Nnoremap("<leader>m", "<cmd>Telescope filetypes<cr>")

Nnoremap("<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>")

Nnoremap("<leader>vrr", "<cmd>Telescope lsp_references<CR>")

