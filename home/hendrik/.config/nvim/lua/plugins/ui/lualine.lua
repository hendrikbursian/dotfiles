local utils = require("modules.utils")

local on_readonly_file = function(value, fallback)
	return function()
		local file_path = vim.api.nvim_buf_get_name(0)
		if file_path == "" or not utils.path.exists(file_path) then
			return fallback
		end

		local is_readonly = vim.api.nvim_buf_get_option(0, "readonly")
		if not is_readonly then
			return fallback
		end

		return value
	end
end

-- Statusline
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		return vim.tbl_deep_extend("keep", opts, {
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",

				disabled_filetypes = {
					"neo-tree",
					"dapui_scopes",
					"dapui_breakpoints",
					"dapui_stacks",
					"dapui_watches",
					"dapui_console",
					"dap-repl",
				},
			},
			sections = {
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
						symbols = {
							readonly = " [READONLY]",
						},
						color = on_readonly_file({ bg = "red", fg = "white" }, {}),
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
