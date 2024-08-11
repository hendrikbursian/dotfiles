-- Remember breakpoints
return {
	"nvim-dap",
	optional = true,
	dependencies = {
		"weissle/persistent-breakpoints.nvim",
		event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<leader>bb", function() require("persistent-breakpoints.api").toggle_breakpoint() end, },
            { "<leader>bB", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, },
            { "<leader>bR", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, },
        },
		opts = {
			load_breakpoints_event = { "BufReadPost" },
		},
	},
}
