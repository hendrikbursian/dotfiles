local ok, _ = pcall(require, "lualine")
if not ok then
    return
end

require('lualine').setup {
    options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = {
            "dapui_scopes",
            "dapui_breakpoints",
            "dapui_stacks",
            "dapui_watches",
            "dapui_console",
            "dap-repl",
        },
    },
    sections = {
        lualine_c = {
            {
                "filename",
                file_status = true,
                path = 1,
                symbols = {
                    readonly = " [READONLY]",
                },
                color = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local is_readonly = vim.api.nvim_buf_get_option(buf, 'readonly')

                    if is_readonly then
                        return { fg = "#ff0000" }
                    else
                        return {}
                    end
                end
            }
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
}

-- lualine.setup {
--     tabline = {},
--     extensions = {},
-- }

-- local ok_web_icons, nvim_web_devicons = pcall(require, "nvim-web-devicons")

-- if ok_web_icons then
--     nvim_web_devicons.setup({
--         -- your personal icons can go here (to override)
--         -- you can specify color or cterm_color instead of specifying both of them
--         -- DevIcon will be appended to `name`
--         override = {
--             zsh = {
--                 icon = "",
--                 color = "#428850",
--                 cterm_color = "65",
--                 name = "Zsh"
--             }
--         };
--         -- globally enable default icons (default to false)
--         -- will get overriden by `get_icons` option
--         default = true;
--     })
-- end

