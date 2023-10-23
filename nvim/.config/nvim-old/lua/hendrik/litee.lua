-- configure the litee.nvim library
require('litee.lib').setup({
    icons = {},
    jumps = {},
    lsp = {},
    navi = {},
    notify = {
        enabled = true,
    },
    panel = {
        orientation = "right",
        panel_size = 30,
    },
    state = {},
    tree = {
        icon_set = "default",
        indent_guides = true
    },
})

-- configure litee-calltree.nvim
require('litee.calltree').setup({})

