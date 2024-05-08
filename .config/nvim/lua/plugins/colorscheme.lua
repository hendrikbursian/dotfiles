local colorscheme = require("modules.colorscheme")

-- stylua: ignore
local keys = {
    { "<leader>cc", function() colorscheme.next() end, noremap = true, silent = true, desc = "Next Colorscheme" },
    { "<leader>cC", function() colorscheme.prev() end, noremap = true, silent = true, desc = "Previous Colorscheme" },
}

local set_overrides = function()
	-- Cursor
	vim.api.nvim_set_hl(0, "Cursor", { bg = "red" })
	vim.api.nvim_set_hl(0, "iCursor", { bg = "red" })

	-- Column indicators
	-- vim.api.nvim_set_hl("ColorColumn", { ctermbg = 0, bg = "red" }, false)

	-- Completion
	-- Remove background from floating menu (better visibility)
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Grey
	vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })

	-- Blue
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
	vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { bg = "NONE", fg = "#569CD6" })

	-- Light blue
	vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindInterface", { bg = "NONE", fg = "#9CDCFE" })
	vim.api.nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", fg = "#9CDCFE" })

	-- Cody
	vim.api.nvim_set_hl(0, "CmpItemKindCody", { fg = "Red" })

	-- Pink
	vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
	vim.api.nvim_set_hl(0, "CmpItemKindMethod", { bg = "NONE", fg = "#C586C0" })

	-- Front
	vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindProperty", { bg = "NONE", fg = "#D4D4D4" })
	vim.api.nvim_set_hl(0, "CmpItemKindUnit", { bg = "NONE", fg = "#D4D4D4" })
end

return {
	{
		"casonadams/nord.vim",
		lazy = false,
		priority = 1000,
		config = function()
			colorscheme.add({
				schema = "nord",
				background = "dark",
				config = function()
					vim.api.nvim_set_hl(0, "Normal", { bg = "#2e3440", fg = "#ffffff" })

					set_overrides()
				end,
			})

			colorscheme.add({
				schema = "nord-light",
				background = "light",
				config = function()
					vim.api.nvim_set_hl(0, "Normal", { bg = "#ffffff", fg = "#2e3440" })

					set_overrides()
				end,
			})
		end,
	},

	{
		"gruvbox-community/gruvbox",
		lazy = false,
		priority = 900,
		config = function()
			colorscheme.add({
				schema = "gruvbox",
				background = "dark",
				config = function()
					vim.g.gruvbox_italic = 1
					vim.g.gruvbox_contrast_dark = "hard"

					set_overrides()
				end,
			})
			colorscheme.add({
				schema = "gruvbox",
				background = "light",
				config = function()
					vim.g.gruvbox_italic = 1
					vim.g.gruvbox_contrast_light = "soft"

					set_overrides()
				end,
			})
		end,
	},

	{
		"NLKNguyen/papercolor-theme",
		priority = 1000,
		keys = keys,
		config = function()
			colorscheme.add({
				schema = "PaperColor",
				background = "light",
				config = set_overrides,
			})
		end,
	},

	{
		"arcticicestudio/nord-vim",
		priority = 1000,
		keys = keys,
		config = function()
			colorscheme.add({
				schema = "nord",
				background = "dark",
				config = function()
					-- transparency
					vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
					vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
					vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
					vim.cmd("hi CursorLine guibg=NONE ctermbg=NONE")
					vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")

					set_overrides()
				end,
			})
		end,
	},

	{
		"navarasu/onedark.nvim",
		priority = 1000,
		keys = keys,
		config = function()
			colorscheme.add({
				schema = "onedark",
				background = "dark",
				config = function()
					set_overrides()
				end,
			})
			colorscheme.add({
				schema = "onedark",
				background = "light",
				config = function()
					set_overrides()
					vim.api.nvim_set_hl(0, "Normal", {
						bg = "#ffffff",
						fg = "#000000",
					})
				end,
			})
		end,
	},
}
