local ok, dap = pcall(require, "dap")
if not ok then
    return
end

local adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }

local ok_dap_vscode_js, dap_vscode_js = pcall(require, "dap-vscode-js")
if ok_dap_vscode_js then
    dap_vscode_js.setup({
        -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
        -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
        -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
        adapters, -- which adapters to register in nvim-dap
    })
end

local file_type_mapping = {}
for _, adapter in pairs(adapters) do
    file_type_mapping[adapter] = { "typescript", "javascript" }
end

require("dap.ext.vscode").load_launchjs(nil, file_type_mapping)

for _, language in ipairs({ "typescript", "javascript" }) do
    -- Add default configurations if no other configurations were found
    if dap.configurations[language] == nil then
        dap.configurations[language] = {
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
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            }
        }
    else
        -- Add process picker for "attach" configurations loaded from "launch.json" files
        for i, _ in ipairs(dap.configurations[language]) do
            if dap.configurations[language][i].request == "attach" and
                dap.configurations[language][i].processId == nil
            then
                dap.configurations[language][i].processId = require "dap.utils".pick_process
            end
        end
    end
end
