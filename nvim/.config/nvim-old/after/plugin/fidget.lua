local ok, fidget = pcall(require, "fidget")
if not ok then
    return
end

fidget.setup({
    strict = true,
    text = {
        spinner = "line",
    },
    window = {
        blend = 28,
    },
    fmt = {
        max_width = 25
    },
})
