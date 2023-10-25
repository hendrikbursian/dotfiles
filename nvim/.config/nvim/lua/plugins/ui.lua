local utils = require("hendrik.utils")

return {
	-- Startscreen
	{
		"mhinz/vim-startify",
		lazy = false,
	},

	-- Symbol highlighting
	{
		"RRethy/vim-illuminate",
		event = utils.FileEvent,
	},

	{
		"rcarriga/nvim-notify",
		event = "VeryLazy",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss all Notifications",
			},
		},
		opts = {
			timeout = 5000,
			-- render = "simple",
			-- stages = "static",
			-- top_down = false,
			-- background_colour = "#000000",
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
		},
		init = function()
			vim.notify = require("notify")
		end,
	},

	{
		"folke/noice.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = function()
			return {
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				cmdline = {
					view = "cmdline",
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "notify",
							min_height = 15,
						},
						view = "split",
					},
					{
						filter = {
							event = "msg_show",
							kind = "",
							find = "written",
						},
						opts = { skip = true },
					},
				},
			}
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = utils.FileEvent,
		opts = function()
			return {
				options = {
					icons_enabled = false,
					component_separators = "|",
					section_separators = "",
					disabled_filetypes = {
						"dapui_scopes",
						"dapui_breakpoints",
						"dapui_stacks",
						"dapui_watches",
						"dapui_console",
						"dap-repl",
					},
				},
				sections = {
					lualine_c = {
						{
							"filename",
							file_status = true,
							path = 1,
							symbols = {
								readonly = " [READONLY]",
							},
							color = function()
								local buf = vim.api.nvim_get_current_buf()
								local is_readonly = vim.api.nvim_buf_get_option(buf, "readonly")

								if is_readonly then
									return { fg = "#ff0000" }
								else
									return {}
								end
							end,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,
	},
}
