return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-copilot",
        dependencies = {
            "github/copilot.vim"
        }
    },
    opts = function(_, opts)
        table.insert(opts.sources, 1, {
            name = "copilot",
            group_index = 1,
            priority = 100
        })
    end
}
