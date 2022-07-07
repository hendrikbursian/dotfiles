vim.g.mapleader = " "

require('hendrik')

local hendrik = vim.api.nvim_create_augroup("hendrik", {})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = hendrik,
    pattern = "*",
    command = '%s/\\s\\+$//e'
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = hendrik,
    pattern = {
        "*.lua",
        "*.go",
        "*.ts",
        "*.js",
        "*.vue",
    },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})

-- autocmd BufEnter,BufWinEnter,TabEnter * :lua require('lsp_extensions').inlay_hints{}

local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", {})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = highlight_yank,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 40 })
    end
})


local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", {})

vim.api.nvim_create_autocmd("BufWritePost", {
    group = packer_user_config,
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile"
})
