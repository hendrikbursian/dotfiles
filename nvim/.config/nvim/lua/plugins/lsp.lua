local utils = require("hendrik.utils")

-- LSP
return {
	{
		"neovim/nvim-lspconfig",
		event = utils.FileEvent,
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

			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			local lsp = require("hendrik.lsp")

			local servers = {
				cssls = {},
				graphql = {},
				html = {},
				lemminx = {},
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
						experimental = {
							-- classRegex = {
							--     "ui:\\s*{([^)]*)\\s*}", "[\"'`]([^\"'`]*).*?[\"'`]",
							--     "/\\*ui\\*/\\s*{([^;]*)}", ":\\s*[\"'`]([^\"'`]*).*?[\"'`]"
							-- }
						},
					},
				},
				volar = {},
			}

			local opts = {
				servers = servers,
				handlers = {
					function(server_name)
						lsp.config_setup(server_name, servers[server_name])
					end,
				},
			}

			return opts
		end,
		config = function(_, opts)
			require("mason-lspconfig").setup({
				automatic_installation = false,
				ensure_installed = vim.tbl_keys(opts.servers),
			})
			require("mason-lspconfig").setup_handlers(opts.handlers)
		end,
	},

	-- Automatically install LSPs
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {},
		config = function(_, opts)
			require("mason").setup(opts)

			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},

	{ import = "plugins.lsp" },

	{ import = "plugins.lsp.lang.typescript" },
	{ import = "plugins.lsp.lang.rust" },
	{ import = "plugins.lsp.lang.intelephense" },
	{ import = "plugins.lsp.lang.yamlls" },
	{ import = "plugins.lsp.lang.jsonls" },
}
