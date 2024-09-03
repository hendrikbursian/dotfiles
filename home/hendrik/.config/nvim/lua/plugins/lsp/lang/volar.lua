return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"neoconf.nvim",
	},
	opts = function(_, opts)
		local utils = require("modules.utils")
		local vue = require("plugins.lsp.lang.helpers").get_vue_config()

		opts.servers.volar = {}
		opts.handlers.volar = function(settings)
			local lsp = require("modules.lsp")
			local lspconfig = require("lspconfig")

			--stylua: ignore
			if vue.language_server == nil then
				vim.print("No language_server path for vue set. Make sure to install @vue/language-service globally and add the path in the neoconf.")
			elseif not utils.path.exists(vue.language_server) then
				vim.print("Path vue.language_server is invalid: " .. vue.language_server .. ". Make sure to install @vue/language-service globally and add the path in the neoconf.")
			end

			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				cmd = { vue.language_server, "--stdio" },
				filetypes = { "vue" },
			})

			--stylua: ignore
			if vue.typescript_lib == nil then
				vim.print("No typescript path for vue set. Make sure to install typescript globally and add the path in the neoconf.")
			elseif not utils.path.exists(vue.typescript_lib) then
				vim.print("Path vue.typescript is invalid: " .. vue.typescript_lib .. ". Make sure to install typescript globally and add the path in the neoconf.")
			else
				vim.tbl_deep_extend("force", config, {
					init_options = {
						typescript = { tsdk = vue.typescript_lib },
					},
				})
			end

			lspconfig.volar.setup(config)
		end

		return opts
	end,
}
