local ok, lint = pcall(require, 'lint')
if not ok then
    return
end

require('lint').linters_by_ft = {
    typescript = { 'eslint_d' },
    vue = { 'eslint_d' },
    javascript = { 'eslint_d' },
}

