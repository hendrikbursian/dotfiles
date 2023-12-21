return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			nav_first_in_list = true,
			--projects = {
			--    ["/home/hendrik/workspace/quokka-backend"] = {
			--        term = {
			--            cmds = {
			--                " from terminal harpoon?"",
			--            }
			--        }
			--    }
			--}
		},
        -- stylua: ignore
        keys = {
            { "<leader>a", function() require("harpoon"):list():append() end },
            { "<C-e>", 
                function()
                    local harpoon = require("harpoon")
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end
            },
            { "<C-j>",     function() require("harpoon"):list():select(1) end },
            { "<C-k>",     function() require("harpoon"):list():select(2) end },
            { "<C-l>",     function() require("harpoon"):list():select(3) end },
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
