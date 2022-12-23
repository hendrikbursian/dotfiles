local view = require "nvim-tree.view"
local api = require "nvim-tree.api"

local M = {}

M.toggle_focused_file = function()
    if view.is_visible() then
        view.close()
    else
        local file_path = vim.fn.expand("%:h")
        api.tree.find_file(file_path)
    end
end

return M
