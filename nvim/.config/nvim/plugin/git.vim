nnoremap <leader>gg :Git<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gt :Git mergetool<CR>
nnoremap <leader>gpp :Git push<CR>
nnoremap <leader>gpf :Git push --force<CR>

vnoremap <leader>gh :GcLog<CR>

function! s:ftplugin_fugitive() abort
    nnoremap <buffer> <silent> ccn :Git commit --no-verify<CR>
    nnoremap <buffer> <silent> can :Git commit --amend --no-verify<CR>
endfunction

augroup hendrik_fugitive
    autocmd!
    autocmd FileType fugitive call s:ftplugin_fugitive()
augroup END
