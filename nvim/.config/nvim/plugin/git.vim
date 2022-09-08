nnoremap <leader>gg :Git<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gt :Git mergetool<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gf :Git push --force<CR>
nnoremap <leader>ga <CMD>Git add %<CR>
nnoremap <leader>gaa :Git add .<CR>
nnoremap <leader>go :Git log<CR>

vnoremap <leader>gh :GcLog<CR>

function! s:ftplugin_fugitive() abort
    nnoremap <buffer> <silent> cn :Git commit --no-verify<CR>
    nnoremap <buffer> <silent> an :Git commit --amend --no-verify<CR>
    nnoremap <buffer> <silent> ae :Git commit --amend --no-verify --no-edit<CR>
endfunction

augroup hendrik_fugitive
    autocmd!
    autocmd FileType fugitive call s:ftplugin_fugitive()
augroup END
