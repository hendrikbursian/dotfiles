return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		opts.servers.volar = {}
		opts.handlers.volar = function(settings)
			local lsp = require("modules.lsp")
			local lspconfig = require("lspconfig")

			local global_ts = vim.fn.system("nix eval nixpkgs#typescript.outPath --raw")
			if vim.v.shell_error ~= 0 then
				vim.print("Command for getting typescript server path not working!")
			end

			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				cmd = { "vue-language-server", "--stdio" },
				on_attach = function(client, bufnr)
					lsp.on_attach(client, bufnr)

					-- typescript does the request and volar doesnt have a handler
					vim.keymap.del("n", "gd", { buffer = bufnr })
				end,
				filetypes = { "vue" },
				init_options = {
					typescript = {
						tsdk = global_ts .. "/lib/node_modules/typescript/lib",
					},
				},
			})

			lspconfig.volar.setup(config)
		end

		return opts
	end,
}
