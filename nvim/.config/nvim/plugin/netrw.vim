let g:netrw_browse_split = 0
" let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3

function ToggleNetrwAtFileFolder()
    let filename = expand('%:h')
    if filename == '.' " netrw open?
        execute 'silent Lexplore'
    else
        execute 'silent Lexplore ' . filename
    endif
endfunction

nnoremap <C-b> <cmd>silent :call ToggleNetrwAtFileFolder()<CR>

