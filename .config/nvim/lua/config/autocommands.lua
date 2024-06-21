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
	end,
})

-- Highlight Yanks
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 40 })
	end,
})

-- Auto root to git directory
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("auto_root"),
	pattern = "*",
	callback = function()
		local utils = require("modules.utils")
		local path = utils.get_git_dir_or_cwd()
		vim.cmd(":lcd " .. path)
	end,
})
