local view = require "nvim-tree.view"
local find_file = require "nvim-tree".find_file
local open = require "nvim-tree".open

require("nvim-tree").setup({
    view = {
        width = '33%'
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    },
    update_focused_file = {
        enable = true,
    },
})

local M = {}

M.toggle_focused_file = function()
    if view.is_visible() then
        view.close()
    else
        local previous_buf = vim.api.nvim_get_current_buf()
        find_file(false, previous_buf)

        local file_path = vim.fn.expand("%:h")
        open(file_path)
    end
end

return M

