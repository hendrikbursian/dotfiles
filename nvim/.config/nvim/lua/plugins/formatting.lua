local utils = require("hendrik.utils")

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

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = function(_, opts)
			local formatters_by_ft = require("config.formatters").formatters_by_ft
			local names = utils.merge_by_ft_table(formatters_by_ft, { "trim_newlines", "trim_whitespaces" })

			opts.ensure_installed = opts.ensure_installed or {}

			for _, name in pairs(names) do
				local mason_name = utils.get_mason_name(name)
				if mason_name ~= nil then
					table.insert(opts.ensure_installed, mason_name)
				end
			end

			return opts
		end,
	},
}