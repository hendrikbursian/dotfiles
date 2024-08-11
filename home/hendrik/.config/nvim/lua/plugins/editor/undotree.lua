return {
	"mbbill/undotree",
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>" },
	},
	init = function()
		vim.g.undotree_WindowLayout = 2
	end,
	enabled = true,
	event = "VeryLazy",
}
