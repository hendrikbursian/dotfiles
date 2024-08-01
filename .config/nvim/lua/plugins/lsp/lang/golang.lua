return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		opts.servers.gopls = {
			gopls = {
				analyses = {
					unreachable = true,
					nilness = true,
					unusedparams = true,
					useany = true,
					unusedwrite = true,
					ST1003 = true,
					undeclaredname = true,
					fillreturns = true,
					nonewvars = true,
					fieldalignment = false,
					shadow = true,
				},
				codelenses = {
					generate = true, -- show the `go generate` lens.
					gc_details = true, -- Show a code lens toggling the display of gc's choices.
					test = true,
					tidy = true,
					vendor = true,
					regenerate_cgo = true,
					upgrade_dependency = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				matcher = "Fuzzy",
				diagnosticsDelay = "500ms",
				symbolMatcher = "fuzzy",
				semanticTokens = true,
				noSemanticTokens = true, -- disable semantic string tokens so we can use treesitter highlight injection
			},
		}

		opts.handlers.tsserver = function(settings)
			local lsp = require("modules.lsp")
			local lspconfig = require("lspconfig")
			local config = vim.tbl_deep_extend("force", lsp.get_default_server_config(settings), {
				filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl", "tmpl" },
				message_level = vim.lsp.protocol.MessageType.Error,
				cmd = {
					"gopls", -- share the gopls instance if there is one already
					"-remote.debug=:0",
				},
				root_dir = function(fname)
					local util = lspconfig.util
					return util.root_pattern("go.work", "go.mod")(fname)
						or util.root_pattern(".git")(fname)
						or util.path.dirname(fname)
				end,
				flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
			})

			lspconfig.gopls.setup(config)
		end
	end,
}
