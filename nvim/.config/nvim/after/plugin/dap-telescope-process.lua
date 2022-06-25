local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require('telescope.themes')

local function get_processes()
    local output = vim.fn.system({'ps', 'a'})
    local lines = vim.split(output, '\n')
    local processes = {}
    for _, line in pairs(lines) do
        -- output format
        --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
        local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
        local pid = parts[1]

        if pid and pid ~= 'PID' then
            pid = tonumber(pid)
            if pid ~= vim.fn.getpid() then
                local process = {
                    pid = pid,
                    name = table.concat({unpack(parts, 5)}, ' '),
                }
                table.insert(processes, process)
            end
        end
    end

    return processes
end

local processes = function(opts)
    pickers.new(opts, {
        prompt_title = "Pick process",
        finder = finders.new_table {
            results = get_processes(),
            entry_maker = function(entry)
               return {
                    value = entry,
                    ordinal = entry.pid .. " " .. entry.name,
                    display = string.format("% 6d  %s", entry.pid, entry.name),
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                print(vim.inspect(selection))
            end)
            return true
        end,
    }):find()
end

local dap_run = require('dap').run
local dap_pick_process = require('dap.utils').pick_process

require('dap').run = function(config, opts)
    if type(config) ~= table then
        dap_run(config, opts)
    elseif config.request == 'attach' and config.processId == dap_pick_process then
        print("looking for process")
        processes(themes.get_dropdown())
    end
end


