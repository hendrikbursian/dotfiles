local nnoremap = require("hendrik.keymap").nnoremap
local nmap  = require("hendrik.keymap").nmap

nnoremap("<leader>n", "<plug>(YoinkPostPasteSwapBack)")
nnoremap("<leader>p", "<plug>(YoinkPostPasteSwapForward)")

nmap("p", "<plug>(YoinkPaste_p)")
nmap("P", "<plug>(YoinkPaste_P)")

nmap("P", "<plug>(YoinkPaste_P)")

-- Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap("gp", "<plug>(YoinkPaste_gp)")
nmap("gP", "<plug>(YoinkPaste_gP)")

nmap("[y", "<plug>(YoinkRotateBack)")
nmap("]y", "<plug>(YoinkRotateForward)")

nmap("<c-=>", "<plug>(YoinkPostPasteToggleFormat)")

vim.g.yoinkSavePersistently = true
vim.g.yoinkSyncSystemClipboardOnFocus = true
vim.g.yoinkIncludeDeleteOperations = true
vim.g.yoinkMaxItems = 30

vim.opt.clipboard = 'unnamedplus'

-- if vim.fn.has('wsl') then
--     local path = vim.fn.expand('<sfile>:p:h')
--     local yank_exe = path .. '/win32yank/win32yank.exe'

--     vim.g.clipboard = {
--         name = 'wslclipboard',
--         cache_enabled = true,
--         copy = {
--             ["+"] = yank_exe .. ' -i --crlf',
--             ["*"] = yank_exe .. ' -i --crlf',
--         },
--         paste = {
--             ["+"] = yank_exe .. ' -o --lf',
--             ["*"] = yank_exe .. ' -o --lf',
--         },
--     }
-- end
