local utils = require("hendrik.utils")

return {
    -- Formatting
    {
        "gpanders/editorconfig.nvim",
        event = utils.FileEvent,
    },

    {
        "mhartington/formatter.nvim",
        event = utils.FileEvent,
        dependencies = { "mfussenegger/nvim-lint" },
        opts = function()
            local lsp_formatter = function()
                vim.lsp.buf.format({ async = false })
            end

            return {
                logging = true,
                log_level = vim.log.levels.WARN,

                filetype = {
                    lua = { require("formatter.defaults").lua },
                    rust = lsp_formatter,

                    css = { require("formatter.defaults").eslint_d },
                    html = { require("formatter.defaults").eslint_d },
                    javascript = { require("formatter.defaults").prettierd, require("formatter.defaults").eslint_d },
                    typescript = { require("formatter.defaults").prettierd, require("formatter.defaults").eslint_d },
                    vue = { require("formatter.defaults").eslint_d },

                    go = { require("formatter.filetypes.go").gofmt },
                    php = { require("formatter.filetypes.php").phpcbf },
                    sh = { require("formatter.filetypes.sh").shfmt },
                    yaml = { require("formatter.filetypes.yaml").prettierd },

                    ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace }
                }
            }
        end,
        config = function(_, opts)
            require("formatter").setup(opts)

            local group = vim.api.nvim_create_augroup("formatter", {})
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "FormatterPost",
                callback = function()
                    require("lint").try_lint()
                end,
            })

            vim.api.nvim_create_autocmd("BufWritePost", {
                group = group,
                callback = function()
                    vim.api.nvim_command("FormatWrite")
                end
            })
        end
    },

}
