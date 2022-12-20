local Remap = require('hendrik.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<F5>', function() require 'dap'.continue() end)
nnoremap('<F10>', function() require 'dap'.step_over({}) end)
nnoremap('<F11>', function() require 'dap'.step_into() end)
nnoremap('<F12>', function() require 'dap'.repl.toggle() end)
