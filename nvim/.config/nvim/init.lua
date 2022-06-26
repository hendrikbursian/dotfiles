print("Loading init")

vim.g.mapleader = " "

require('hendrik')

local hendrik = vim.api.nvim_create_augroup("hendrik", {})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = hendrik,
    pattern = { "*.lua", ".go" },
    callback = function()
        vim.lsp.buf.formatting({ async = true })
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = hendrik,
    pattern = { "*.js", "*.ts" },
    command = "Neoformat"
})

-- autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_seq_sync({}, 1000, {'eslint', 'tsserver', 'rome'})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = hendrik,
    pattern = "*",
    command = '%s/\\s\\+$//e'
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
