-- Extended Typescript Tools
return {
	"neovim/nvim-lspconfig",
	dependencies = { "jose-elias-alvarez/typescript.nvim" },
	opts = function(_, opts)
		opts.servers.tsserver = {
			javascript = {
				suggest = {
					enable = false,
					completeFunctionCalls = false,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			typescript = {
				enablePromptUseWorkspaceTsdk = true,
				format = {
					enable = false,
				},
				suggest = {
					enable = true,
					completeFunctionCalls = true,
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		}

		opts.handlers.tsserver = function()
			local lsp = require("modules.lsp")

			require("typescript").setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				server = {
					capabilities = lsp.get_capabilities(),
					on_attach = lsp.on_attach,
					settings = settings,
				},
			})
		end

		return opts
	end,
}
