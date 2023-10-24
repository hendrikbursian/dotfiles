local function augroup(name)
    return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Format Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("format_terminal"),
	pattern = "*",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.cmd("startinsert")
	end
})

-- TODO: Check this
-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 40 })
	end
})

-- TODO: not working yet
-- Set filetypes for custom files
local group = augroup("filetype")
local custom_filetypes = {
    { pattern = "*.yml.template", filetype = "yaml" },
    { pattern = "*.conf.template", filetype = "nginx" },
}
for _, ft in pairs(custom_filetypes) do
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        group = group,
        pattern = ft.pattern,
        callback = function()
            vim.bo.filetype = ft.filetype
        end
    })
end
