nnoremap <leader>n <plug>(YoinkPostPasteSwapBack)
nnoremap <leader>p <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

nmap P <plug>(YoinkPaste_P)
" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

nmap <c-=> <plug>(YoinkPostPasteToggleFormat)

let g:yoinkSavePersistently = 1
let g:yoinkSyncSystemClipboardOnFocus = 1
let g:yoinkIncludeDeleteOperations = 1

" set clipboard=unnamed

