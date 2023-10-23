local utils = require("hendrik.utils")

return {
    -- Linting
    {
        "mfussenegger/nvim-lint",
        event = utils.FileEvent,
        config = function()
            require("lint").linters_by_ft = {
                typescript = { "eslint_d" },
                vue = { "eslint_d" },
                javascript = { "eslint_d" },
            }
        end
    },
}
