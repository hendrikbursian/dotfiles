local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    return
end

nvim_tree.setup({
    create_in_closed_folder = true,
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
})
