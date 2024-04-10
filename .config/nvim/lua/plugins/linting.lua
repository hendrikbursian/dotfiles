local utils = require("hendrik.utils")

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

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = function(_, opts)
			local linters_by_ft = require("config.linters").linters_by_ft
			local names = utils.merge_by_ft_table(linters_by_ft, {})

			opts.ensure_installed = opts.ensure_installed or {}

			for _, name in pairs(names) do
				local mason_name = utils.get_mason_name(name)
				if mason_name ~= nil then
					table.insert(opts.ensure_installed, mason_name)
				end
			end

			return opts
		end,
	},
}
