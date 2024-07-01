return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		opts.servers.html = {}
		opts.handlers["html"] = function(settings)
			local lsp = require("modules.lsp")
			local capabilities = lsp.get_capabilities()

			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				cmd = { "vscode-html-language-server", "--stdio" },
				filetypes = { "html", "templ" },
				single_file_support = true,
			})

			require("lspconfig").html.setup(config)
		end

		return opts
	end,
}
