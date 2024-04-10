return {
	{
		"mbbill/undotree",
		enabled = false,
		event = "VeryLazy",
	},

	{
		"tpope/vim-unimpaired",
		event = "VeryLazy",
		keys = {
			{ "]n", "<Plug>(unimpaired-context-next)zz" },
			{ "[n", "<Plug>(unimpaired-context-previous)zz" },
		},
	},
	-- { "tpope/vim-obsession" },

	-- search/replace in multiple files
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
		keys = {
			{ "<leader>fr", function() 	require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
	},

	-- Markdown viewer
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{ import = "plugins.editor" },
}
