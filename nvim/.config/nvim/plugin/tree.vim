let g:nvim_tree_create_in_closed_folder = 1
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }
let g:nvim_tree_show_icons = { 'files' : 0 }
let g:nvim_tree_highlight_opened_files = 3

nnoremap <C-b> <cmd>:lua require('hendrik.tree').toggle_focused_file()<CR>

