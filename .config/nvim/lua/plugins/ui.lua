local banned_messages = {
	"No LSP References found",
	"Request textDocument/prepareRename failed with message: You cannot rename this element.",
}

return {
	-- Startscreen
	{
		"mhinz/vim-startify",
		lazy = false,
		config = function()
			local function git_modified()
				local files = vim.fn.systemlist("git ls-files -m 2>/dev/null")
				return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
			end

			local function git_untracked()
				local files = vim.fn.systemlist("git ls-files -o --exclude-standard 2>/dev/null")
				return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
			end

			vim.g.startify_custom_header = {
				"   Home",
				"",
				"   =============================================================================",
			}
			vim.g.startify_enable_special = 0

			-- stylua: ignore
			vim.g.startify_lists = {
				{ type = git_modified,  header = { "   Git modified" } },
				{ type = "dir",         header = { "   MRU " .. vim.loop.cwd() } },
				{ type = "files",       header = { "   MRU" } },
				{ type = git_untracked, header = { "   Git untracked" } },
				{ type = "bookmarks",   header = { "   Bookmarks" } },
				{ type = "commands",    header = { "   Commands" } },
			}
		end,
	},

	-- Symbol highlighting
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
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
			render = "simple",
			stages = "static",
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
			vim.notify = function(msg, ...)
				for _, banned_msg in ipairs(banned_messages) do
					if string.find(msg, banned_msg) then
						vim.print(msg, ...)
						return
					end
				end
				require("notify")(msg, ...)
			end
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

	{ import = "plugins.ui.lualine" },
}
