return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",

			"nvim-neotest/neotest-go",
		},
		lazy = false,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("neotest").setup({
				adapters = {
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
					}),
				},
				status = {
					enabled = true,
					signs = true,
					virtual_text = true,
				},
				output = {
					enabled = true,
					open_on_run = true,
				},
			})
		end,
        -- stylua: ignore
        keys = {
            { "<leader>tt", function() require("neotest").run.run() end,                                            desc = "Run Nearest" },
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
		"mfussenegger/nvim-dap",
		optional = true,
        -- stylua: ignore
        keys = {
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
        },
	},
}
