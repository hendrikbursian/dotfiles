-- Extended Typescript Tools

local ts_neoconf_defaults = {
	vue_plugin_path = nil,
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"jose-elias-alvarez/typescript.nvim",
		"folke/neoconf.nvim",
	},
	opts = function(_, opts)
		require("neoconf.plugins").register({
			on_schema = function(schema)
				schema:set("ts_server.vue_plugin_path", {
					description = "Path to the @vue/typescript-plugin path",
					type = "string",
				})
			end,
		})

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

			local ts_neoconf = require("neoconf").get("ts_server", ts_neoconf_defaults)

			if ts_neoconf.vue_plugin_path == nil then
				vim.print(
					"tsserver lsp setup: cannot find vue plugin for typescript. run `pnpm install --global @vue/typescript-plugin` then `pnpm list --global @vue/typescript-plugin` and paste path into global neoconf (~/.config/nvim/neoconf.json)"
				)
			else
				table.insert(ts_config.server.init_options.plugins, {
					name = "@vue/typescript-plugin",
					location = ts_neoconf.vue_plugin_path,
					languages = { "javascript", "typescript", "vue" },
				})
			end

			require("typescript").setup(ts_config)
		end

		return opts
	end,
}
