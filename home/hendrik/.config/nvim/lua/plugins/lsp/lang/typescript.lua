-- Extended Typescript Tools

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neoconf.nvim",
		"nvim-lua/plenary.nvim",
		"pmizio/typescript-tools.nvim",
	},
	opts = function(_, opts)
		opts.servers.ts_ls = {
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

		opts.handlers.ts_ls = function(settings)
			local lsp = require("modules.lsp")

			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				init_options = {
					plugins = {},
				},
				filetypes = {
					"javascript",
					"javascript.jsx",
					"javascriptreact",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
					"vue",
				},
				single_file_support = true,
			})

			local vue = require("plugins.lsp.lang.helpers").get_vue_config()

			if vue.typescript_plugin == nil then
				vim.print("ts_ls lsp setup: cannot find @vue/typescript-plugin")
			else
				table.insert(config.init_options.plugins, {
					name = "@vue/typescript-plugin",
					location = vue.typescript_plugin,
					languages = { "javascript", "typescript", "vue" },
				})
			end

			require("lspconfig").ts_ls.setup(config)
		end

		return opts
	end,
}
