-- Context lines
return {
	"nvim-treesitter/nvim-treesitter-context",
	event = "VeryLazy",
	opts = {
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		throttle = true, -- Throttles plugin updates (may improve performance)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		show_all_context = false,
		patterns = {
			-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
			-- For all filetypes
			-- Note that setting an entry here replaces all other patterns for this entry.
			-- By setting the "default" entry below, you can control which nodes you want to
			-- appear in the context window.
			default = {
				"function",
				"method",
				"for",
				"while",
				"if",
				"switch",
				"case",
			},

			rust = {
				"loop_expression",
				"impl_item",
			},

			typescript = {
				"class_declaration",
				"abstract_class_declaration",
				"else_clause",
			},
		},
	},
	config = function(_, opts)
		function ContextSetup(show_all_context)
			opts.show_all_context = show_all_context
			require("treesitter-context").setup(opts)
		end

		vim.keymap.set("n", "<leader>cf", function()
			ContextSetup(true)
		end)
		vim.keymap.set("n", "<leader>cp", function()
			ContextSetup(false)
		end)
		ContextSetup(false)
	end,
}
