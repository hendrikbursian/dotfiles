local view = require "nvim-tree.view"
local api = require "nvim-tree.api"

local M = {}

M.toggle_focused_file = function()
    if view.is_visible() then
        view.close()
    else
        local file_path = vim.api.nvim_buf_get_name(0)
        local file_dir = file_path:match("(.*/)")

        api.tree.open(file_dir)
        api.tree.find_file(file_path)
    end
end

return M
