return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	cmd = "Leet",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

		"nvim-treesitter/nvim-treesitter",
		"rcarriga/nvim-notify",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		lang = "go",
		keys = {
			toggle = { "q" },
			confirm = { "<CR>" },

			reset_testcases = "R",
			use_testcase = "U",
			focus_testcases = "H",
			focus_result = "L",
		},
	},
}
