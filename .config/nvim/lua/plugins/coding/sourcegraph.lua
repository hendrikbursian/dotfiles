return {
	{
		"sourcegraph/sg.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-lspconfig" },
		opts = function()
			local lsp = require("hendrik.lsp")

			return {
				on_attach = lsp.on_attach,
			}
		end,
	},
}
