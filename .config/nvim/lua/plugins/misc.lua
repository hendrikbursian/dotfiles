return {
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"ianding1/leetcode.vim",
		cmd = {
			"LeetCodeList",
			"LeetCodeTest",
			"LeetCodeSubmit",
			"LeetCodeSignIn",
		},
		config = function()
			vim.g.leetcode_browser = "firefox"
			vim.g.leetcode_solution_filetype = "golang"
			vim.g.leetcode_hide_paid_only = true
		end,
	},
}
