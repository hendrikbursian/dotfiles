local dap_install = require("dap-install")
dap_install.setup({
    installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})
dap_install.config("jsnode", {})

local dap = require("dap")
dap.configurations.typescript = {
    {
        name = 'Run',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
        outFiles = {"${workspaceFolder}/build/**/*.js"},
    },
    {
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require'dap.utils'.pick_process,
        skipFiles = {
            "<node_internals>/**",
            "**/node_modules/**"
        }
    },
}

local api = vim.api
local keymap_restore = {}
dap.listeners.after.event_initialized.me = function()
    for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == "K" then
                table.insert(keymap_restore, keymap)
                api.nvim_buf_del_keymap(buf, 'n', 'K')
            end
        end
    end
    api.nvim_set_keymap(
    'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
end

dap.listeners.after.event_terminated.me = function()
    for _, keymap in pairs(keymap_restore) do
        api.nvim_buf_set_keymap(
            keymap.mode,
            keymap.buffer,
            keymap.lhs,
            keymap.rhs,
            {
                silent = keymap.silent == 1
            }
        )
    end
    keymap_restore = {}
end

require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = true,                  -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

local M = {}

-- function M.pick_process()
--     local output = vim.fn.system({'ps', 'a'})
--     local lines = vim.split(output, '\n')
--     local procs = {}
--     for _, line in pairs(lines) do
--         -- output format
--         --    " 107021 pts/4    Ss     0:00 /bin/zsh <args>"
--         local parts = vim.fn.split(vim.fn.trim(line), ' \\+')
--         local pid = parts[1]
--         local name = table.concat({unpack(parts, 5)}, ' ')
--         if pid and pid ~= 'PID' then
--             pid = tonumber(pid)
--             if pid ~= vim.fn.getpid() then
--                 table.insert(procs, { pid = pid, name = name })
--             end
--         end
--     end
--     local label_fn = function(proc)
--         return string.format("id=%d name=%s", proc.pid, proc.name)
--     end
--     local result = require('dap.ui').pick_one_sync(procs, "Select process", label_fn)
--     return result and result.pid or nil
-- end

return M

