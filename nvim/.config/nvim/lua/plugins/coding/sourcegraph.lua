local utils = require("hendrik.utils")

return {
	{
		"sourcegraph/sg.nvim",
		event = utils.FileEvent,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-lspconfig" },
		opts = function()
			local lsp = require("hendrik.lsp")

			return {
				on_attach = lsp.on_attach,
			}
		end,
	},
}
