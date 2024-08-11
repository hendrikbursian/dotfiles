-- Todo list
return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
        { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
	opts = {
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*]],
		},
		search = {
			pattern = [[\b(KEYWORDS)\b]],
		},
	},
}
