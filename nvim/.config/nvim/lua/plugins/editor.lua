local utils = require("hendrik.utils")

return {

    -- Session management
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
        -- stylua: ignore
        keys = {
            { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            {
                "<leader>qd",
                function() require("persistence").stop() end,
                desc =
                "Don't Save Current Session"
            },
        },
    },

    {
        "mbbill/undotree",
        event = utils.FileEvent,
    },

    -- {
    --     "tummetott/unimpaired.nvim",
    --     event = "VeryLazy",
    -- },

    {
        "tpope/vim-unimpaired",
        event = "VeryLazy",
        keys = {
            { "]n", "<Plug>(unimpaired-context-next)zz" },
            { "[n", "<Plug>(unimpaired-context-previous)zz" },
        }
    },
    -- { "tpope/vim-obsession" },

    -- search/replace in multiple files
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            { "<leader>fr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },

    -- Outline
    {
        "simrat39/symbols-outline.nvim",
        keys = {
            { "<leader>o", ":SymbolsOutline<cr>" },
        },
        opts = {
            highlight_hovered_item = true,
            show_guides = true,
            auto_preview = true,
            position = "right",
            relative_width = true,
            width = 25,
            auto_close = false,
            show_numbers = false,
            show_relative_numbers = false,
            show_symbol_details = true,
            preview_bg_highlight = "Pmenu",
            keymaps = { -- These keymaps can be a string or a table for multiple keys
                close = { "<Esc>", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "<C-space>",
                toggle_preview = "K",
                rename_symbol = "r",
                code_actions = "a",
            },
            lsp_blacklist = {},
            symbol_blacklist = {},
            symbols = {
                File = { icon = "", hl = "TSURI" },
                Module = { icon = "", hl = "TSNamespace" },
                Namespace = { icon = "", hl = "TSNamespace" },
                Package = { icon = "", hl = "TSNamespace" },
                Class = { icon = "𝓒", hl = "TSType" },
                Method = { icon = "ƒ", hl = "TSMethod" },
                Property = { icon = "", hl = "TSMethod" },
                Field = { icon = "", hl = "TSField" },
                Constructor = { icon = "", hl = "TSConstructor" },
                Enum = { icon = "ℰ", hl = "TSType" },
                Interface = { icon = "ﰮ", hl = "TSType" },
                Function = { icon = "", hl = "TSFunction" },
                Variable = { icon = "", hl = "TSConstant" },
                Constant = { icon = "", hl = "TSConstant" },
                String = { icon = "𝓐", hl = "TSString" },
                Number = { icon = "#", hl = "TSNumber" },
                Boolean = { icon = "⊨", hl = "TSBoolean" },
                Array = { icon = "", hl = "TSConstant" },
                Object = { icon = "⦿", hl = "TSType" },
                Key = { icon = "🔐", hl = "TSType" },
                Null = { icon = "NULL", hl = "TSType" },
                EnumMember = { icon = "", hl = "TSField" },
                Struct = { icon = "𝓢", hl = "TSType" },
                Event = { icon = "🗲", hl = "TSType" },
                Operator = { icon = "+", hl = "TSOperator" },
                TypeParameter = { icon = "𝙏", hl = "TSParameter" }
            },
        }
    },

    -- Markdown viewer
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },

    -- Todo list
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = utils.FileEvent,
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>ft", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    },

    { import = "plugins.editor.neo-tree" },
    -- { import = "plugins.editor.nvim-tree" },
    { import = "plugins.editor.harpoon" },

    { import = "plugins.editor.vim-dadbod" },
}
