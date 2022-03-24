nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ hidden = true, shorten_path = true })<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <C-p> <cmd>lua require('hendrik.telescope').project_files()<cr>

