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
				enabled = true,
				severity = vim.log.levels.TRACE,
			},
			output = {
				enabled = true,
				open_on_run = "short",
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                                            desc = "Run Nearest" },
            { "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end,                              desc = "Run All Test Files" },
            { "<leader>tf", function() require("neotest").run.run(vim.api.nvim_buf_get_name(0)) end,                desc = "Run File" },
            { "<leader>tl", function() require("neotest").run.run_last() end,                                       desc = "Run Last" },
            { "<leader>te", function() require("neotest").summary.toggle() end,                                     desc = "Test Explorer" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,                                     desc = "Toggle Summary" },
            { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,     desc = "Show Output" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,                                desc = "Toggle Output Panel" },
            { "<leader>tS", function() require("neotest").run.stop() end,                                           desc = "Stop" },
        },
	},

	{
		"nvim-neotest/neotest",
		dependencies = { "nvim-neotest/neotest-go" },
		opts = function(_, opts)
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
		"mfussenegger/nvim-dap",
		optional = true,
        -- stylua: ignore
        keys = {
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
        },
	},
}
