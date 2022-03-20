nnoremap <leader>fs <cmd>lua require('telescope.builtin').grep_string()<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<CR>

nnoremap <C-p> <cmd>lua require('hendrik.telescope').project_files()<CR>

nnoremap <leader>dot <cmd>lua require('hendrik.telescope').search_dotfiles({ hidden = true })<CR>
nnoremap <leader>nat <cmd>lua require('hendrik.telescope').search_naturallife()<CR>


"cnnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>
"
" nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
" nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
" nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
" nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
" nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
" nnoremap <leader>gc :lua require('theprimeagen.telescope').git_branches()<CR>
" nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
" nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
" nnoremap <leader>td :lua require('theprimeagen.telescope').dev()<CR>


