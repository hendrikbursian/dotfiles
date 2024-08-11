return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"telescope.nvim",
	},
        -- stylua: ignore
		keys = {
            { "<leader>re",  function() require("refactoring").refactor("Extract Function") end,         mode = "x" },
            { "<leader>rf",  function() require("refactoring").refactor("Extract Function To File") end, mode = "x" },
            { "<leader>rv",  function() require("refactoring").refactor("Extract Variable") end,         mode = "x" },
            { "<leader>rI",  function() require("refactoring").refactor("Inline Function") end,          mode = "n" },
            { "<leader>ri",  function() require("refactoring").refactor("Inline Variable") end,          mode = { "n", "x" } },
            { "<leader>rb",  function() require("refactoring").refactor("Extract Block") end,            mode = "n" },
            { "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,    mode = "n" },
            { "<leader>rr",  function() require("telescope").extensions.refactoring.refactors() end,     mode = { "n", "x" } }
		},
	config = function()
		require("refactoring").setup()
		require("telescope").load_extension("refactoring")
	end,
}
