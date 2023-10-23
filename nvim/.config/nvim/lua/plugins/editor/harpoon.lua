return {
    {
        "ThePrimeagen/harpoon",
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
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end },
            { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end },
            { "<C-j>",     function() require("harpoon.ui").nav_file(1) end },
            { "<C-k>",     function() require("harpoon.ui").nav_file(2) end },
            { "<C-l>",     function() require("harpoon.ui").nav_file(3) end },
        },
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
                        end
                    },
                    renderers = {
                        file = file
                    }
                },
            })
        end
    }
}
