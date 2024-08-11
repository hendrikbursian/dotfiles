return {
	{
		"lualine.nvim",
		dependencies = {
			{ "arkav/lualine-lsp-progress" },
		},
		opts = {
			sections = {
				lualine_y = {
					{
						"lsp_progress",
						display_components = { "lsp_client_name", "spinner" },
						separators = {
							component = " ",
							progress = " | ",
							message = {
								pre = "(",
								commenced = "In Progress",
								completed = "Completed",
								post = ")",
							},
							percentage = { pre = "", post = "%% " },
							title = { pre = "", post = ": " },
							lsp_client_name = { pre = "[", post = "]" },
							spinner = { pre = "", post = "" },
						},
						timer = { progress_enddelay = 1000, spinner = 200, lsp_client_name_enddelay = 1000 },
						spinner_symbols = { "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏", "⠋", "⠙", "⠹" },
					},
				},
			},
		},
	},
}
