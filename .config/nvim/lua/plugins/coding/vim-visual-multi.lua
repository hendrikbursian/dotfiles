-- Multi Cursor
return {
	"mg979/vim-visual-multi",
	branch = "master",
	event = "VeryLazy",
	config = function()
		vim.g.VM_mouse_mappings = 1
		vim.g.VM_maps.Undo = "u"
		vim.g.VM_mapsRedo = "<C-r>"
	end,
}
