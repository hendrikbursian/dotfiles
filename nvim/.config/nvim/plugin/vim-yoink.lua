vim.keymap.set("n", "<leader>n", "<plug>(YoinkPostPasteSwapBack)")
vim.keymap.set("n", "<leader>p", "<plug>(YoinkPostPasteSwapForward)")

vim.keymap.set("n", "p", "<plug>(YoinkPaste_p)")
vim.keymap.set("n", "P", "<plug>(YoinkPaste_P)")

vim.keymap.set("n", "P", "<plug>(YoinkPaste_P)")

-- Also replace the default gp with yoink paste so we can toggle paste in this case too
vim.keymap.set("n", "gp", "<plug>(YoinkPaste_gp)")
vim.keymap.set("n", "gP", "<plug>(YoinkPaste_gP)")

vim.g.yoinkSavePersistently = true
vim.g.yoinkSyncSystemClipboardOnFocus = true
vim.g.yoinkIncludeDeleteOperations = true
vim.g.yoinkMaxItems = 30

vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(["`r"], ""))',
        ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
}
