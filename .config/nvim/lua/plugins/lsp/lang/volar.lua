local volar_default_neoconf = {
	typescript_path = nil,
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"neoconf.nvim",
	},
	opts = function(_, opts)
		local utils = require("modules.utils")
		require("neoconf.plugins").register({
			on_schema = function(schema)
				schema:set("volar.typescript_path", {
					description = "Path to the typescript library",
					type = "string",
				})
			end,
		})

		local volar_neoconf = require("neoconf").get("volar", volar_default_neoconf)

		opts.servers.volar = {}
		opts.handlers.volar = function(settings)
			local lsp = require("modules.lsp")
			local lspconfig = require("lspconfig")

			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				cmd = { "vue-language-server", "--stdio" },
				filetypes = { "vue" },
			})

			if volar_neoconf.typescript_path == nil or not utils.path.exists(volar_neoconf.typescript_path) then
				vim.print(
					"Path volar.typescript_path is invalid: "
						.. volar_neoconf.typescript_path
						.. ". Make sure to install typescript globally and add the path in the neoconf."
				)
			else
				vim.tbl_deep_extend("force", config, {
					init_options = {
						typescript = {
							tsdk = volar_neoconf.typescript_path .. "/lib/node_modules/typescript/lib",
						},
					},
				})
			end

			lspconfig.volar.setup(config)
		end

		return opts
	end,
}
