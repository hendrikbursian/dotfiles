return {
	{
		"anuvyklack/hydra.nvim",
		dependencies = {
			"nvim-dap",
			{
				"nvim-lualine/lualine.nvim",
				opts = function(_, opts)
					local state = require("modules.hydra").state
					local colors = require("modules.hydra").colors

					opts.sections = {
						lualine_a = {
							{
								"mode",
								cond = function()
									return not state.active
								end,
							},
							{
								function()
									return state.name
								end,
								cond = function()
									return state.active
								end,
								color = function()
									if state.color == nil then
										return { bg = colors.red }
									end

									return { bg = colors[state.color] }
								end,
							},
						},
					}

					return opts
				end,
			},
		},
		config = function()
			require("plugins.editor.hydra.dap")
			require("plugins.editor.hydra.scrolling")
		end,
	},
}
