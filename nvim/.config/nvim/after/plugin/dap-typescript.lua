local adapters ={ 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }

require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters, -- which adapters to register in nvim-dap
})

local file_type_mapping = {}
for _, adapter in pairs(adapters) do
    file_type_mapping[adapter] = { 'typescript', 'javascript' }
end

require('dap.ext.vscode').load_launchjs(nil, file_type_mapping)

if require('dap').configurations.typescript == nil then
    for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
            {
                type = "pwa-node",
                request = "attach",
                name = "Attach",
                processId = require 'dap.utils'.pick_process,
                cwd = "${workspaceFolder}",
            }
        }
    end
end

require('dap').set_log_level('TRACE')
