return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
		},
		opts = {
			adapters = {},
			status = {
				enabled = true,
				signs = true,
				virtual_text = false,
			},
			diagnostic = {
				enabled = false,
				severity = vim.log.levels.TRACE,
			},
			output = {
				enabled = false,
				open_on_run = false,
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                          desc = "Run Nearest" },
            { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end,                              desc = "Run All Test Files" },
            { "<leader>tf", function() require("neotest").run.run(vim.api.nvim_buf_get_name(0)) end,                desc = "Run File" },
            { "<leader>tl", function() require("neotest").run.run_last() end,                                       desc = "Run Last" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,                                     desc = "Toggle Summary" },
            { "<leader>to", function() require("neotest").output_panel.open({ enter = true, auto_close = true, last_run = false }) end,     desc = "Show Output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,                                desc = "Toggle Output Panel" },
            { "<leader>tS", function() require("neotest").run.stop() end,                                           desc = "Stop" },
        },
	},

	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-go" },

		opts = function(_, opts)
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			table.insert(
				opts.adapters,
				require("neotest-go")({
					experimental = {
						test_table = true,
					},
				})
			)

			return opts
		end,
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			{ "nvim-neotest/neotest-jest" },
		},
		opts = function(_, opts)
			table.insert(opts.adapters, require("neotest-jest"))

			return opts
		end,
	},

	{
		"nvim-dap",
		optional = true,
        -- stylua: ignore
        keys = {
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap", suite = false }) end, desc = "Debug Nearest" },
        },
	},
}
