-- Extended Rust Tools
return {
	"neovim/nvim-lspconfig",
	dependencies = { "simrat39/rust-tools.nvim" },
	opts = function(_, opts)
		opts.servers.rust_analyzer = {}
		opts.handlers.rust_analyzer = function()
			local lsp = require("hendrik.lsp")
			local rust_tools = require("rust-tools")

			rust_tools.setup({
				server = {
					on_attach = function(client, bufnr)
						lsp.on_attach(client, bufnr)

						vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
						vim.keymap.set("n", "<leader>s", function()
							vim.cmd("RustRun")
						end, { buffer = bufnr })
					end,
				},
			})
		end

		return opts
	end,
}
