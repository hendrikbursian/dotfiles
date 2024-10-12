local M = {}

local qf_l = 0
local qf_g = 0

-- Source: ThePrimeagen
-- Toggle quickfix or location list
function M.toggle_qf_list(global)
	if global then
		if qf_g == 1 then
			qf_g = 0
			pcall(vim.api.nvim_command, "cclose")
		else
			qf_g = 1
			pcall(vim.api.nvim_command, "copen")
		end
	else
		if qf_l == 1 then
			qf_l = 0
			pcall(vim.api.nvim_command, "lclose")
		else
			qf_l = 1
			pcall(vim.api.nvim_command, "lopen")
		end
	end
end

-- Read nix home-manager theme and set accordingly
M.refreshColorTheme = function()
	local uv = vim.loop
	local utils = require("modules.utils")

	local themeFile = os.getenv("THEME_FILE")
	if themeFile == nil then
		vim.notify("Missing THEME_FILE environment variable")
		return
	end

	if not utils.path.is_file(themeFile) then
		vim.notify('THEME_FILE "' .. themeFile .. '" is not a file')
		return
	end

	local fd = uv.fs_open(themeFile, "r", 0444)
	if fd == nil then
		vim.notify("Cannot open theme file: " .. themeFile)
		return
	end

	local theme = uv.fs_read(fd, 128)
	if fd == nil then
		vim.notify("Cannot read theme file: " .. themeFile)
		return
	end

	if theme == "nord-light" then
		vim.api.nvim_command("set background=light")
		vim.api.nvim_command("colorscheme nord-light")
		vim.api.nvim_set_hl(0, "Normal", { bg = "#ffffff", fg = "#2e3440" })
	elseif theme == "nord" then
		vim.api.nvim_command("set background=dark")
		vim.api.nvim_command("colorscheme nord")
		vim.api.nvim_set_hl(0, "Normal", { bg = "#2e3440", fg = "#ffffff" })
	elseif theme == "gruvbox" then
		vim.api.nvim_command("colorscheme retrobox")
		vim.api.nvim_command("set background=dark")
	else
		vim.notify("Unsupported theme: " .. theme .. ". Falling back to base16-scheme")
		vim.api.nvim_command("colorscheme base16-scheme")
		vim.api.nvim_command("set background=dark")
	end
end

return M
