local ok, lint = pcall(require, "lint")
if not ok then
    return
end

lint.linters_by_ft = {
    sh = { "shellcheck" },
    typescript = { "eslint_d" },
    vue = { "eslint_d" },
    javascript = { "eslint_d" },
}
