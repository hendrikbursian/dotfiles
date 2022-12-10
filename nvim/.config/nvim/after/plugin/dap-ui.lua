local ok, dapui = pcall(require, "dapui")
local ok_dap, dap = pcall(require, "dap")
if not ok or not ok_dap then
    return
end

dapui.setup()

dap.listeners.after.event_breakpoint["dapui_config"] = function()
    dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end
