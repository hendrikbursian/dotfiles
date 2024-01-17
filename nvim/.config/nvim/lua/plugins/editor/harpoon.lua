return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			local utils = require("hendrik.utils")

			return {
				settings = {
					key = utils.get_git_dir_or_cwd,
				},
				default = {
					get_root_dir = utils.get_git_dir_or_cwd,
				},
			}
		end,
        -- stylua: ignore
        keys = {
            { "<leader>a", function() require("harpoon"):list():append() end },
            "<C-e>",
            -- { "<C-e>", 
            --     function()
            --         local harpoon = require("harpoon")
            --         harpoon.ui:toggle_quick_menu(harpoon:list())
            --     end
            -- },
            { "<C-S-j>",     function() require("harpoon"):list():select(1) end },
            { "<C-S-k>",     function() require("harpoon"):list():select(2) end },
            { "<C-S-l>",     function() require("harpoon"):list():select(3) end },
            { "<C-S-;>",     function() require("harpoon"):list():select(4) end },

             -- Toggle previous & next buffers stored within Harpoon list
            { "<C-S-p>",     function() require("harpoon"):list():prev() end },
            { "<C-S-n>",     function() require("harpoon"):list():next() end },
        },
		config = function(_, opts)
			local harpoon = require("harpoon")
			local config = require("telescope.config").values

			vim.print(opts)
			harpoon:setup(opts)

			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end
				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),

						previewer = config.file_previewer({}),
						sorter = config.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<C-e>", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open harpoon window" })
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		optional = true,
		dependencies = { "ThePrimeagen/harpoon" },
		opts = function(_, opts)
			local file = vim.deepcopy(require("neo-tree.defaults").renderers.file)
			table.insert(file[3].content, { "harpoon_index", zindex = 10 })

			return vim.tbl_deep_extend("force", opts, {
				filesystem = {
					components = {
						harpoon_index = function(config, node, state)
							local Marked = require("harpoon.mark")
							local path = node:get_id()
							local succuss, index = pcall(Marked.get_index_of, path)
							if succuss and index and index > 0 then
								return {
									text = string.format(" ⥤ %d", index),
									highlight = config.highlight or "NeoTreeDirectoryIcon",
								}
							else
								return {}
							end
						end,
					},
					renderers = {
						file = file,
					},
				},
			})
		end,
	},
}
