local remap = require("hendrik.remap")

local nnoremap = remap.nnoremap;
local vnoremap = remap.vnoremap;

nnoremap("<leader>gs", ":Git<CR>", { silent = true })
nnoremap("<leader>gl", ":Git pull<CR>", { silent = true })
nnoremap("<leader>gt", ":Git mergetool<CR>", { silent = true })
nnoremap("<leader>gp", ":Git push<CR>", { silent = true })
nnoremap("<leader>gf", ":Git push --force<CR>", { silent = true })
nnoremap("<leader>ga", ":Git add %<CR>", { silent = true })
nnoremap("<leader>gaa", ":Git add .<CR>", { silent = true })
nnoremap("<leader>go", ":Git log<CR>", { silent = true })
vnoremap("<leader>gh", ":GcLog<CR>", { silent = true })

local group = vim.api.nvim_create_augroup("hendrik_fugitive", {})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "fugitive",
    callback = function()
        nnoremap("cn", ":Git commit --no-verify<CR>", { silent = true, buffer = true })
        nnoremap("an", ":Git commit --amend --no-verify<CR>", { silent = true, buffer = true })
        nnoremap("ae", ":Git commit --amend --no-verify --no-edit<CR>", { silent = true, buffer = true })
    end
})
