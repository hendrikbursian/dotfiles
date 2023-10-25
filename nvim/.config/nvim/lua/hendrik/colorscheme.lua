local function is_dark_mode()
	if vim.fn.has("wsl") == 1 or vim.fn.has("win32") == 1 then
		local apps_use_light_theme_value = vim.fn.system(
			'cmd.exe /c reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme'
		)

		if vim.v.shell_error ~= 0 then
			return true
		end

		if apps_use_light_theme_value == nil then
			return true
		end

		return string.match(apps_use_light_theme_value, "0x0")
	end

	-- TODO:
	return true
end

local colorschemes = {}

local current_colorscheme = nil

local function apply_colorscheme(index)
	vim.print("Setting colorscheme " .. colorschemes[index].schema)

	vim.opt.background = colorschemes[index].background
	vim.cmd("colorscheme " .. colorschemes[index].schema)

	if colorschemes[index].config then
		colorschemes[index].config()
	end
end

local M = {}

M.add = function(colorscheme)
	colorschemes[#colorschemes + 1] = colorscheme
end

M.init = function()
	if current_colorscheme ~= nil then
		return
	end

	if is_dark_mode() then
		current_colorscheme = 1
	else
		current_colorscheme = 2
	end

	apply_colorscheme(current_colorscheme)
end

function M.next()
	current_colorscheme = current_colorscheme % #colorschemes + 1
	apply_colorscheme(current_colorscheme)
end

function M.prev()
	current_colorscheme = (current_colorscheme - 2) % #colorschemes + 1
	apply_colorscheme(current_colorscheme)
end

return M
