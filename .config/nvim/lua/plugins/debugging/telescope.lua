return {
	"nvim-dap",
	dependencies = {
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
}
