-- Formatting
return {
	{
		"stevearc/conform.nvim",
		dependencies = { "nvim-lint" },
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>vf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = function()
			local function get_on_format_callback()
				return function(err)
					if err then
						return
					end

					require("lint").try_lint()
				end
			end

			return {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "eslint_d", "eslint", "prettierd", "prettier" },
					typescript = { "eslint_d", "eslint", "prettierd", "prettier" },
					css = { "eslint_d", "prettierd", "prettier" },
					html = { "eslint_d", "prettierd", "prettier" },
					vue = { "eslint_d", "prettierd", "prettier" },
					go = { "goimports", "gofmt" },
					rust = { "rustfmt" },
					sh = { "shellcheck", "shfmt" },
					bash = { "shfmt" },
					sql = { "sql_formatter" },
					yaml = { "prettierd", "prettier" },
					json = { "prettier" },
					php = { "phpcbf" },
					templ = { "templ" },
					nix = { "nixpkgs_fmt" },
					blade = { "blade-formatter" },
					markdown = { "mdfmt" },

					-- filetypes without defined formatters
					["_"] = { "trim_newlines", "trim_whitespace" },

					-- every filetype (including the above ones)
					["*"] = { "trim_newlines", "trim_whitespace" },
				},

				format_on_save = false,

				format_after_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end

					local on_format = get_on_format_callback()

					return { lsp_fallback = true, stop_after_first = true }, on_format
				end,

				notify_on_error = true,

				-- Customize formatters
				formatters = {
					-- shfmt = {
					--     prepend_args = { "-i", "2" },
					-- },
					mdfmt = {
						command = "mdfmt",
						stdin = false,
						args = { "-w", "$FILENAME" },
					},
				},
			}
		end,
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = function(_, opts)
			-- let eslint only run if a config is found
			require("conform.formatters.markdownfmt").command = "mdfmt"

			require("conform.formatters.eslint_d").cwd = require("conform.util").root_file({
				".eslint.js",
				".eslint.cjs",
				".eslint.yaml",
				".eslint.yml",
				".eslint.json",
			})
			require("conform.formatters.eslint_d").require_cwd = true

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable global formatting
					vim.g.disable_autoformat = true
				else
					-- ... FormatDisable just for this buffer
					vim.b.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function(args)
				if args.bang then
					vim.g.disable_autoformat = false
				end
				vim.b.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
				bang = true,
			})

			require("conform").setup(opts)
		end,
	},
}
