return {
	"sourcegraph/sg.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-lspconfig",
	},
	-- stylua: ignore
	keys = {
		{ "<leader>cs", function() require("s.extensions.telescope").fuzzy_search_results() end, desc = "Sourcegraph fuzzy search" },
		{ "<leader>ca", ":CodyAsk ", mode = { "v" } },
		{ "<leader>ce", ":CodyExplain<CR>", mode = { "v" } },
		{ "<leader>ct", ":CodyTask ", mode = { "v", "n" } },
		{ "<leader>co", "<cmd>CodyChat<CR>", mode = { "n" } },
		{ "<leader>cO", "<cmd>CodyChat!<CR>", mode = { "n" } },
		{ "yoC", "<cmd>CodyToggle<CR>", mode = { "n" } },
	},
	build = "nvim -l build/init.lua",
	opts = function()
		local lsp = require("modules.lsp")

		return {
			on_attach = lsp.on_attach,
			node_executable = os.getenv("HOME") .. "/.nix-profile/bin/node",
			chat = {
				default_model = "anthropic/claude-3-haiku-20240307",
			},
		}
	end,
}
