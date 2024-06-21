return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = function()
			return {
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
					key = function()
						local utils = require("modules.utils")
						return utils.get_git_dir_or_cwd()
					end,
				},
				default = {
					get_root_dir = function()
						local utils = require("modules.utils")
						return utils.get_git_dir_or_cwd()
					end,
				},
			}
		end,
        -- stylua: ignore
        keys = {
            { "<leader>a", function() require("harpoon"):list():add() end },
            { "<C-e>",
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end
            },
            { "<C-j>",     function() require("harpoon"):list():select(1) end },
            { "<C-k>",     function() require("harpoon"):list():select(2) end },
            { "<C-l>",     function() require("harpoon"):list():select(3) end },
            -- { "<C-;>",     function() require("harpoon"):list():select(4) end },

             -- Toggle previous & next buffers stored within Harpoon list
            -- { "<C-S-p>",     function() require("harpoon"):list():prev() end },
            -- { "<C-S-n>",     function() require("harpoon"):list():next() end },
        },
		config = function(_, opts)
			local harpoon = require("harpoon")
			harpoon:setup(opts)
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
