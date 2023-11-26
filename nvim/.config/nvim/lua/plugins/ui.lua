local utils = require("hendrik.utils")

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

            -- stylua: ignore
			vim.g.startify_lists = {
				{ type = "sessions",    header = { "   Sessions" } },
				{ type = git_modified,  header = { "   Git modified" } },
				{ type = "dir",         header = { "   MRU " .. vim.loop.cwd() } },
				{ type = "files",       header = { "   MRU" } },
				{ type = git_untracked, header = { "   Git untracked" } },
				{ type = "bookmarks",   header = { "   Bookmarks" } },
				{ type = "commands",    header = { "   Commands" } },
			}

			local function get_session_name()
				local path = vim.fn.fnamemodify(vim.loop.cwd(), ":~:t")
				if vim.fn.empty(path) then
					path = "no-project"
				end
				local branch = vim.fn.system({ "git", "branch", "--show-current" })
				if vim.fn.empty(branch) then
					branch = ""
				else
					branch = "-" .. branch
				end

				return vim.fn.substitute(path .. branch, "/", "-", "g")
			end

			local group = vim.api.nvim_create_augroup("config_startify", { clear = true })

			-- vim.api.nvim_create_autocmd("User", {
			-- 	group = group,
			-- 	pattern = "StartifyReady",
			-- 	callback = function()
			-- 		vim.cmd("SLoad " .. get_session_name())
			-- 	end,
			-- })

			vim.api.nvim_create_autocmd("VimLeavePre", {
				group = group,
				pattern = "*",
				callback = function()
					vim.cmd("SSave! " .. get_session_name())
				end,
			})
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

	{ import = "plugins.ui.lualine" },
}
