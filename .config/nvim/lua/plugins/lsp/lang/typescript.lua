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

		opts.handlers.tsserver = function(settings)
			local lsp = require("modules.lsp")

			local vue_plugin_paths =
				vim.fn.system("pnpm list --global @vue/typescript-plugin --parseable --fail-if-no-match")
			if vim.v.shell_error ~= 0 then
				vim.print("tsserver lsp setup: Failed to find @vue/typescript-plugin")
			end

			local vue_plugin_path = nil
			for line in vue_plugin_paths:gmatch("[^\r\n]+") do
				if line:find("@vue/typescript-plugin", nil, true) then
					vue_plugin_path = line
					break
				end
			end

			if vue_plugin_path == nil then
				vim.print("tsserver lsp setup: cannot find vue plugin for typescript")
			end

			require("typescript").setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				server = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_plugin_path,
								languages = { "javascript", "typescript", "vue" },
							},
						},
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
			})
		end

		return opts
	end,
}
