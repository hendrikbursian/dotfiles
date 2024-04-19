local utils = require("modules.utils")

return {
	{
		"antosha417/nvim-lsp-file-operations",
		event = "LspAttach",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = true,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<C-b>",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = utils.get_git_dir_or_cwd() })
				end,
				desc = "Explorer NeoTree (root)",
			},
			{
				"<M-b>",
				function()
					local reveal_file = vim.api.nvim_buf_get_name(0)
					local dir

					if reveal_file == "" then
						reveal_file = vim.loop.cwd()
						dir = reveal_file
					else
						dir = reveal_file:match("(.*/)")
					end

					if utils.path.exists(dir) then
						require("neo-tree.command").execute({
							toggle = true,
							reveal = true,
							dir = dir,
							reveal_file = reveal_file,
							reveal_force_cwd = true,
						})
					else
						require("neo-tree.command").execute({
							toggle = true,
							dir = utils.get_git_dir_or_cwd(),
						})
					end
				end,
				desc = "Explorer NeoTree (cwd)",
			},
			{
				"<leader>ge",
				function()
					require("neo-tree.command").execute({ source = "git_status", toggle = true })
				end,
				desc = "Git explorer",
			},
			{
				"<leader>be",
				function()
					require("neo-tree.command").execute({ source = "buffers", toggle = true })
				end,
				desc = "Buffer explorer",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc(-1) == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = function()
			local function getTelescopeOpts(state, path)
				return {
					cwd = path,
					search_dirs = { path },
					attach_mappings = function(prompt_bufnr, map)
						local actions = require("telescope.actions")
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local action_state = require("telescope.actions.state")
							local selection = action_state.get_selected_entry()
							local filename = selection.filename
							if filename == nil then
								filename = selection[1]
							end
							-- any way to open the file without triggering auto-close event of neo-tree?
							require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
						end)
						return true
					end,
				}
			end

			return {
				sources = { "filesystem", "buffers", "git_status", "document_symbols" },
				open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
				filesystem = {
					bind_to_cwd = false,
					follow_current_file = {
						enabled = false,
					},
					use_libuv_file_watcher = true,
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
				window = {
					mappings = {
						["/"] = "none",
						["<space>"] = "none",
						["S"] = "none",
						["f"] = "none",
						["w"] = "none",

						["<C-v>"] = "open_vsplit",
						["<C-x>"] = "open_split",
						["ff"] = "telescope_find",
						["fg"] = "telescope_grep",
						["s"] = "system_open",
						["Y"] = "copy_path",
					},
				},
				commands = {
					system_open = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()

						vim.ui.open(path)
					end,
					telescope_find = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").find_files(getTelescopeOpts(state, path))
					end,
					telescope_grep = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
					end,
					copy_path = function(state)
						-- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
						-- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local filename = node.name
						local modify = vim.fn.fnamemodify

						local results = {
							filepath,
							modify(filepath, ":."),
							modify(filepath, ":~"),
							filename,
							modify(filename, ":r"),
							modify(filename, ":e"),
						}

						-- absolute path to clipboard
						local i = vim.fn.inputlist({
							"Choose to copy to clipboard:",
							"1. Absolute path: " .. results[1],
							"2. Path relative to CWD: " .. results[2],
							"3. Path relative to HOME: " .. results[3],
							"4. Filename: " .. results[4],
							"5. Filename without extension: " .. results[5],
							"6. Extension of the filename: " .. results[6],
						})

						if i > 0 then
							local result = results[i]
							if not result then
								return print("Invalid choice: " .. i)
							end
							vim.fn.setreg('"', result)
							vim.notify("Copied: " .. result)
						end
					end,
				},
				default_component_configs = {
					indent = {
						with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
						expander_collapsed = "",
						expander_expanded = "",
						expander_highlight = "NeoTreeExpander",
					},
				},
			}
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)

			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},
}
