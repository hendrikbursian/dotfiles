local ok, lualine = pcall(require, 'lualine')
if not ok then
    return
end

lualine.setup {
    options = {
        icons_enabled = true,
        -- theme = 'PaperColor',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            'dapui_scopes',
            'dapui_breakpoints',
            'dapui_stacks',
            'dapui_watches',
            'dapui_console',
            'dap-repl',
        },
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,

                symbols = {
                    -- TOOD: Red color or something with more attention
                    readonly = ' [READONLY]',
                }
            }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {},
}

local ok_web_icons, nvim_web_devicons = pcall(require, 'nvim-web-devicons')

if ok_web_icons then
    nvim_web_devicons.setup({
        -- your personal icons can go here (to override)
        -- you can specify color or cterm_color instead of specifying both of them
        -- DevIcon will be appended to `name`
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh"
            }
        };
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
    })
end
