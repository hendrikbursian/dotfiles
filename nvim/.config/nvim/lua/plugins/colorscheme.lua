local colorscheme = require("hendrik.colorscheme")

local keys = {
    { "<leader>cc", function() colorscheme.next() end, noremap = true, silent = true, desc = "Next Colorscheme" },
    { "<leader>cC", function() colorscheme.prev() end, noremap = true, silent = true, desc = "Previous Colorscheme" },
}

return {
    {
        "casonadams/nord.vim",
        lazy = false,
        config = function()
            colorscheme.add({
                schema = "nord",
                background = "dark",
            })

            colorscheme.add({
                schema = "nord-light",
                background = "light"
            })
        end
    },

    {
        "gruvbox-community/gruvbox",
        priority = 1000,
        keys = keys,
        config = function()
            colorscheme.add({
                schema = "gruvbox",
                background = "dark",
                config = function()
                    vim.g.gruvbox_italic = 1
                    vim.g.gruvbox_contrast_dark = "hard"
                end
            })
            colorscheme.add({
                schema = "gruvbox",
                background = "light",
                config = function()
                    vim.g.gruvbox_italic = 1
                    vim.g.gruvbox_contrast_light = "soft"
                end
            })
        end
    },

    {
        "NLKNguyen/papercolor-theme",
        priority = 1000,
        keys = keys,
        config = function()
            colorscheme.add({
                schema = "PaperColor",
                background = "light"
            })
        end
    },

    {
        "arcticicestudio/nord-vim",
        priority = 1000,
        keys = keys,
        config = function()
            colorscheme.add({
                schema = "nord",
                background = "dark",
                config = function()
                    -- transparency
                    -- vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
                    -- vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
                    -- vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
                    -- vim.cmd("hi CursorLine guibg=NONE ctermbg=NONE")
                    -- vim.cmd("hi StatusLine guibg=NONE ctermbg=NONE")
                end
            })
        end
    },

    {
        "navarasu/onedark.nvim",
        priority = 1000,
        keys = keys,
        config = function()
            colorscheme.add({
                schema = "onedark",
                background = "dark",
            })
        end
    },
}
