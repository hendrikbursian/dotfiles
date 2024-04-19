local colorschemes = {
	dark = {},
	light = {},
}
local dark_colorscheme_index = 1
local light_colorscheme_index = 1

local function is_color_dark(color)
	-- Convert color code to RGB components
	local r = tonumber(color:sub(2, 3), 16) / 255
	local g = tonumber(color:sub(4, 5), 16) / 255
	local b = tonumber(color:sub(6, 7), 16) / 255

	-- Calculate luminance using relative luminance formula
	local luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b

	-- Return true if luminance is less than or equal to 0.5 (considered dark), otherwise false
	return luminance <= 0.5
end

local function is_windows()
	return vim.fn.has("wsl") == 1 or vim.fn.has("win32") == 1
end

local function is_linux()
	local uname_output = vim.fn.system("uname")
	return uname_output:match("^Linux")
end

local function is_dark_mode()
	if is_windows() then
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
	elseif is_linux() then
		local terminal_color = vim.fn.system('xrdb -query | grep "gnome.terminal.color0" | cut -d "\t" -f2')
		return is_color_dark(terminal_color)
	end

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

local function find_schema_index(colorschemes, scheme_name)
	for i, v in ipairs(colorschemes) do
		if v.schema == scheme_name then
			return i
		end
	end

	return nil
end

local did_init = false
M.init = function()
	if did_init == true then
		return
	end

	if is_linux() then
		local regolith_look = vim.fn.system('xrdb -query | grep "regolith.look:" | cut -f2')
		if string.match(regolith_look, "gruvbox") then
			local index = find_schema_index(colorschemes.dark, "gruvbox")
			if index ~= nil then
				dark_colorscheme_index = index
			end
		elseif string.match(regolith_look, "nord") then
			local index = find_schema_index(colorschemes.dark, "nord")
			if index ~= nil then
				dark_colorscheme_index = index
			end
		end
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
