return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			-- Additional lua configuration
			{
				"folke/neodev.nvim",
				opts = {
					library = {
						plugins = { "neotest" },
						types = true,
					},
				},
			},
		},
		opts = function()
			local servers = {
				cssls = {},
				-- ccls = {
				gopls = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
				graphql = {},
				lemminx = {},
				-- jsonls = {},
				lua_ls = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						hint = { enable = true },
					},
				},
				prismals = {},
				tailwindcss = {
					tailwindCSS = {
						includeLanguages = {
							templ = "html",
						},
						experimental = {
							-- classRegex = {
							--     "ui:\\s*{([^)]*)\\s*}", "[\"'`]([^\"'`]*).*?[\"'`]",
							--     "/\\*ui\\*/\\s*{([^;]*)}", ":\\s*[\"'`]([^\"'`]*).*?[\"'`]"
							-- }
						},
					},
				},
				templ = {},
			}

			local handlers = {}

			local opts = {
				servers = servers,
				handlers = handlers,
			}

			return opts
		end,
		config = function(_, opts)
			local lsp = require("modules.lsp")

			for server_name, server_config in pairs(opts.servers) do
				if opts.handlers[server_name] == nil then
					lsp.config_setup(server_name, server_config)
				else
					opts.handlers[server_name](server_config)
				end
			end
		end,
	},

	{ import = "plugins.lsp" },

	{ import = "plugins.lsp.lang.volar" },
	{ import = "plugins.lsp.lang.typescript" },
	{ import = "plugins.lsp.lang.rust" },
	{ import = "plugins.lsp.lang.intelephense" },
	{ import = "plugins.lsp.lang.yamlls" },
	{ import = "plugins.lsp.lang.jsonls" },
	{ import = "plugins.lsp.lang.html" },
}
