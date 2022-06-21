nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>

nnoremap <leader>fh :Telescope help_tags<cr>
nnoremap <leader>dot <cmd>lua require('hendrik.telescope').search_dotfiles()<cr>

nnoremap <C-p> <cmd>lua require('hendrik.telescope').project_files()<cr>
nnoremap <leader>m :Telescope filetypes<cr>

nnoremap <leader>ds :Telescope lsp_document_symbols<CR>
nnoremap <leader>vrr :Telescope lsp_references<CR>

nnoremap <leader>gw <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gm <cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
