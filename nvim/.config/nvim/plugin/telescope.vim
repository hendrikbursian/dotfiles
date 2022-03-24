nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({ hidden = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep({ hidden = true})<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers({ hidden = true})<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags({ hidden = true})<cr>

nnoremap <C-p> <cmd>lua require('hendrik.telescope').project_files({ hidden = true})<cr>

