local utils = require("modules.utils")

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
			local formatters_by_ft = require("config.formatters").formatters_by_ft

			local slow_format_filetypes = {}

			local function get_on_format_callback(bufnr, sync)
				return function(err)
					if sync then
						if err and err:match("timeout$") then
							slow_format_filetypes[vim.bo[bufnr].filetype] = true
						end
					end

					if err then
						return
					end

					require("lint").try_lint()
				end
			end

			return {
				formatters_by_ft = formatters_by_ft,

				format_on_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end

					-- Guard against slow formatters
					if slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end

					local on_format = get_on_format_callback(bufnr, true)

					return { timeout_ms = 200, lsp_fallback = true }, on_format
				end,

				format_after_save = function(bufnr)
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end

					-- Guard against fast formatters
					if not slow_format_filetypes[vim.bo[bufnr].filetype] then
						return
					end

					local on_format = get_on_format_callback(bufnr, false)

					return { lsp_fallback = true }, on_format
				end,

				notify_on_error = true,

				-- Customize formatters
				formatters = {
					-- shfmt = {
					--     prepend_args = { "-i", "2" },
					-- },
				},
			}
		end,
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = function(_, opts)
			-- let eslint only run if a config is found
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
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			require("conform").setup(opts)
		end,
	},
}
