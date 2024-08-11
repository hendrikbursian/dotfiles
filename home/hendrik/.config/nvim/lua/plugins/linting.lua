-- Linting
return {
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			local linters_by_ft = require("config.linters").linters_by_ft

			require("lint").linters.eslint_d.args = {
				"--no-warn-ignored",
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			}
			require("lint").linters_by_ft = linters_by_ft
		end,
	},
}
