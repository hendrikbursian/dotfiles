return {

    {
        "antosha417/nvim-lsp-file-operations",
        event = "LspAttach",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-tree.lua",
        },
        config = true,
    },

    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "kyazdani42/nvim-web-devicons", },
        keys = {
            {
                "<C-b>",
                function()
                    local view = require "nvim-tree.view"
                    local api = require "nvim-tree.api"

                    if view.is_visible() then
                        view.close()
                    else
                        local file_path = vim.api.nvim_buf_get_name(0)
                        local file_dir = file_path:match("(.*/)")

                        api.tree.open(file_dir)
                        api.tree.find_file(file_path)
                    end
                end,
                desc = "Toggle Side[b]ar"
            }
        },
        opts = {
            renderer = {
                special_files = {
                    "README.md",
                    "Makefile",
                    "MAKEFILE",
                },
                highlight_opened_files = "all",
                icons = {
                    show = {
                        file = false
                    }
                },
            },
            view = {
                width = "33%"
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                    quit_on_open = true,
                }
            },
            git = {
                ignore = false,
            },
            update_focused_file = {
                enable = true,
            },
        },
        config = function(_, opts)
            require("nvim-tree").setup(opts)
            require("nvim-tree").config.system_open.cmd = "wslview"
        end
    }
}
