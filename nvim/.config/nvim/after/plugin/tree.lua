local view = require "nvim-tree.view"
local find_file = require "nvim-tree".find_file
local open = require "nvim-tree".open

require("nvim-tree").setup({
    create_in_closed_folder = true,
    renderer = {
        special_files = {
            'README.md',
            'Makefile',
            'MAKEFILE',
        },
        highlight_opened_files = "all",
        icons = {
            show = {
                file = false
            }
        },
    },
    view = {
        width = '33%'
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
})
