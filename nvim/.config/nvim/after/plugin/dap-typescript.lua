local adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }

require("dap-vscode-js").setup({
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters
})

-- Set typescript and javascript as filetypes for the above mentioned adapters,
-- when loading from launch.json files
local type_to_filetypes = {}
for _, adapter in ipairs(adapters) do
    type_to_filetypes[adapter] = { 'typescript', 'javascript' }
end
require("dap.ext.vscode").load_launchjs(nil,
    type_to_filetypes)

-- If no launch.json was found default to this
if require("dap").configurations.typescript == nil then
    for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations.typescript = {
            name = "Attach",
            type = "pwa-node",
            request = "attach",
            processId = require 'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
        }
    end
end
