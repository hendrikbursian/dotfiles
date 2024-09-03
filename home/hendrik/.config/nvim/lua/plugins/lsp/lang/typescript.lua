-- Extended Typescript Tools

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"jose-elias-alvarez/typescript.nvim",
		"folke/neoconf.nvim",
	},
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

		opts.handlers.tsserver = function(settings)
			local lsp = require("modules.lsp")

			local ts_config = {
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				server = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
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
				}),
			}

			local vue = require("plugins.lsp.lang.helpers").get_vue_config()

			if vue.typescript_plugin == nil then
				vim.print("tsserver lsp setup: cannot find @vue/typescript-plugin")
			else
				table.insert(ts_config.server.init_options.plugins, {
					name = "@vue/typescript-plugin",
					location = vue.typescript_plugin,
					languages = { "javascript", "typescript", "vue" },
				})
			end

			require("typescript").setup(ts_config)
		end

		return opts
	end,
}
