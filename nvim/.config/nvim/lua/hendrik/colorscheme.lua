local colorschemes = {
	dark = {},
	light = {},
}
local dark_colorscheme_index = 1
local light_colorscheme_index = 1

local function is_dark_mode()
	if vim.fn.has("wsl") == 1 or vim.fn.has("win32") == 1 then
		local apps_use_light_theme_value = vim.fn.system(
			'cmd.exe /c reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme'
		)

		if vim.v.shell_error ~= 0 then
			return vim.opt.background:get() == "dark"
		end

		if apps_use_light_theme_value == nil then
			return vim.opt.background:get() == "dark"
		end

		return string.match(apps_use_light_theme_value, "0x0")
	end

	-- TODO:
	return vim.opt.background:get() == "dark"
end

local function apply_colorscheme(colorschemes, index, print_schema)
	if print_schema == nil or print_schema == true then
		print("Setting colorscheme " .. colorschemes[index].schema)
	end

	vim.cmd("colorscheme " .. colorschemes[index].schema)
	if colorschemes[index].config then
		colorschemes[index].config()
	end
end

local M = {}

M.add = function(colorscheme)
	if colorscheme.background == "light" then
		colorschemes.light[#colorschemes.light + 1] = colorscheme
	else
		colorschemes.dark[#colorschemes.dark + 1] = colorscheme
	end
end

local did_init = false
M.init = function()
	if did_init == true then
		return
	end

	if is_dark_mode() then
		vim.opt.background = "dark"
		apply_colorscheme(colorschemes.dark, dark_colorscheme_index, false)
	else
		vim.opt.background = "light"
		apply_colorscheme(colorschemes.light, light_colorscheme_index, false)
	end

	did_init = true
end

function M.next()
	if vim.opt.background:get() == "light" then
		light_colorscheme_index = light_colorscheme_index % #colorschemes.light + 1
		apply_colorscheme(colorschemes.light, light_colorscheme_index)
	else
		dark_colorscheme_index = dark_colorscheme_index % #colorschemes.dark + 1
		apply_colorscheme(colorschemes.dark, dark_colorscheme_index)
	end
end

function M.prev()
	if vim.opt.background:get() == "light" then
		light_colorscheme_index = (light_colorscheme_index - 2) % #colorschemes.light + 1
		apply_colorscheme(colorschemes.light, light_colorscheme_index)
	else
		dark_colorscheme_index = (dark_colorscheme_index - 2) % #colorschemes.dark + 1
		apply_colorscheme(colorschemes.dark, dark_colorscheme_index)
	end
end

local group = vim.api.nvim_create_augroup("config_colorschemes", { clear = true })

local bg = nil
vim.api.nvim_create_autocmd("OptionSet", {
	group = group,
	pattern = "background",
	callback = function()
		if bg == vim.opt.background:get() then
			return
		else
			bg = vim.opt.background:get()
		end

		if vim.opt.background:get() == "light" then
			apply_colorscheme(colorschemes.light, light_colorscheme_index)
		else
			apply_colorscheme(colorschemes.dark, dark_colorscheme_index)
		end
	end,
})

return M
