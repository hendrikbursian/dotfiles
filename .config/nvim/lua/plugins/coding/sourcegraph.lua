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
		{ "<leader>cs", function() require("sg.extensions.telescope").fuzzy_search_results() end, desc = "Sourcegraph fuzzy search", },
		{ "<leader>ca", function() vim.cmd(":CodyAsk") end, mode = { "v" } },
		{ "<leader>ce", function() vim.cmd(":CodyExplain") end, mode = { "v" } },
		{ "<leader>co", function() vim.cmd(":CodyChat") end },
		{ "<leader>cO", function() vim.cmd(":CodyChat!") end },
		{ "<leader>ct", function() vim.cmd(":CodyToggle") end },
		{ "<leader>cT", function() vim.cmd(":CodyTask") end, mode = { "v" } },
		{ "<leader>cR", function() vim.cmd(":CodyRestart") end },
	},
	build = "nvim -l build/init.lua",
	opts = function()
		local lsp = require("modules.lsp")

		return {
			on_attach = lsp.on_attach,
			node_executable = os.getenv("HOME") .. "/.nix-profile/bin/node",
		}
	end,
}
