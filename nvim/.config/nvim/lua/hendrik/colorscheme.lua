local colorschemes = require("config.colorschemes")

local M = {}

M.current_colorscheme = 0

local function apply_colorscheme(index)
    vim.cmd("colorscheme " .. colorschemes[index].schema)
    vim.opt.background = colorschemes[index].background
    if colorschemes[index].config then
        colorschemes[index].config()
    end
end

function M.load() 
    if M.current_colorscheme == 0 then
        -- Read windows dark mode settings with WSL
        local output = vim.fn.system(
            'cmd.exe /c reg query "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme')
        if vim.v.shell_error == 0 then
            if string.match(output, "0x0") then
                apply_colorscheme(1)
            else
                apply_colorscheme(2)
            end
        else
            apply_colorscheme(1)
        end
    end
end

function M.next()
    M.current_colorscheme = M.current_colorscheme % #colorschemes + 1
    apply_colorscheme(M.current_colorscheme)
end

function M.prev()
    M.current_colorscheme = (M.current_colorscheme - 2) % #colorschemes + 1
    apply_colorscheme(M.current_colorscheme)
end

return M;

