local M = {}

local qf_l = 0
local qf_g = 0

-- Source: ThePrimeagen
-- Toggle quickfix or location list
function M.toggle_qf_list(global)
    if global then
        if qf_g == 1 then
            qf_g = 0
            pcall(vim.api.nvim_command, 'cclose')
        else
            qf_g = 1
            pcall(vim.api.nvim_command, 'copen')
        end
    else
        if qf_l == 1 then
            qf_l = 0
            pcall(vim.api.nvim_command, 'lclose')
        else
            qf_l = 1
            pcall(vim.api.nvim_command, 'lopen')
        end
    end
end

return M
