local utils = require("hendrik.utils")

-- Statusline
return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function(_, opts)
		local red_on_existing_file = function()
			local file_path = vim.api.nvim_buf_get_name(0)
			if file_path == "" or not utils.path.exists(file_path) then
				return {}
			end

			local is_readonly = vim.api.nvim_buf_get_option(0, "readonly")
			if not is_readonly then
				return {}
			end

			return { fg = "#ff0000" }
		end

		return vim.tbl_deep_extend("keep", opts, {
			options = {
				icons_enabled = false,
				component_separators = "|",
				section_separators = "",

				disabled_filetypes = {
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
						color = red_on_existing_file,
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
