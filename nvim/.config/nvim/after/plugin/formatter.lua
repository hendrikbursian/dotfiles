local ok, formatter = pcall(require, "formatter")
if not ok then
    return
end

local lsp_formatter = function()
    vim.lsp.buf.format({ async = false })
end

formatter.setup {
    logging = true,
    log_level = vim.log.levels.WARN,

    filetype = {
        lua = lsp_formatter,
        rust = lsp_formatter,

        css = { require("formatter.defaults").eslint_d },
        html = { require("formatter.defaults").eslint_d },
        javascript = { require("formatter.defaults").eslint_d },
        typescript = { require("formatter.defaults").eslint_d },
        vue = { require("formatter.defaults").eslint_d },

        go = { require("formatter.filetypes.go").gofmt },
        php = { require("formatter.filetypes.php").phpcbf },
        yaml = { require("formatter.filetypes.yaml").prettierd },

        ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace }
    }
}

local formatting = vim.api.nvim_create_augroup("formatting", {})
vim.api.nvim_create_autocmd("User", {
    group = formatting,
    pattern = "FormatterPost",
    callback = function()
        require("lint").try_lint()
    end,
})
