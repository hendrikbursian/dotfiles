local group = vim.api.nvim_create_augroup("filetypedetect", {})

local filetype_map = {
    { pattern = "*.yml.template", filetype = "yaml" },
    { pattern = "*.conf.template", filetype = "nginx" },
}

for _, ft in pairs(filetype_map) do
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = ft.pattern,
        callback = function()
            vim.bo.filetype = ft.filetype
        end
    })
end
