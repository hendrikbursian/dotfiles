-- Clipboard
return {
	"svermeulen/vim-yoink",
	event = "VeryLazy",
	enable = false,
	keys = {
		{ "<leader>n", "<plug>(YoinkPostPasteSwapBack)" },
		{ "<leader>p", "<plug>(YoinkPostPasteSwapForward)" },

		{ "p", "<plug>(YoinkPaste_p)" },
		{ "P", "<plug>(YoinkPaste_P)" },

		-- default gp with yoink paste so we can toggle paste in this case too
		{ "gp", "<plug>(YoinkPaste_gp)" },
		{ "gP", "<plug>(YoinkPaste_gP)" },
	},
	config = function()
		vim.g.yoinkSavePersistently = true
		vim.g.yoinkSyncSystemClipboardOnFocus = true
		vim.g.yoinkIncludeDeleteOperations = true
		vim.g.yoinkMaxItems = 30

		-- vim.opt.clipboard = 'unnamedplus'
	end,
}
