return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({ "*" }, { mode = "background" })
	end,
}
