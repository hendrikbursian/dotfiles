" Jump qlist
nnoremap <leader>k :lnext<CR>zz
nnoremap <leader>j :lprev<CR>zz

nnoremap <C-q> :call ToggleQFList(1)<CR>zz
nnoremap <leader>q :call ToggleQFList(0)<CR>zz

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            let g:the_primeagen_qf_g = 0
            cclose
        else
            let g:the_primeagen_qf_g = 1
            copen
        end
    else
        if g:the_primeagen_qf_l == 1
            let g:the_primeagen_qf_l = 0
            lclose
        else
            let g:the_primeagen_qf_l = 1
            lopen
        end
    endif
endfun
