vim.keymap.set("n", "<leader>gs", ":Git<CR>", { silent = true })
vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", { silent = true })
vim.keymap.set("n", "<leader>gt", ":Git mergetool<CR>", { silent = true })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { silent = true })
vim.keymap.set("n", "<leader>gf", ":Git push --force<CR>", { silent = true })
vim.keymap.set("n", "<leader>go", ":Git log<CR>", { silent = true })
vim.keymap.set("v", "<leader>gh", ":GcLog<CR>", { silent = true })
vim.keymap.set("n", "<leader>gW", ":Gwrite<CR>", { silent = true })

local group = vim.api.nvim_create_augroup("hendrik_fugitive", {})

vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "fugitive",
    callback = function()
        vim.keymap.set("n", "cn", ":Git commit --no-verify<CR>", { silent = true, buffer = true })
        vim.keymap.set("n", "an", ":Git commit --amend --no-verify<CR>", { silent = true, buffer = true })
        vim.keymap.set("n", "ae", ":Git commit --amend --no-verify --no-edit<CR>", { silent = true, buffer = true })
    end
})
