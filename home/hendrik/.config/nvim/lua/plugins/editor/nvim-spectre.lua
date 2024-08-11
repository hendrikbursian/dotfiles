-- search/replace in multiple files
return {
	"nvim-pack/nvim-spectre",
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
		keys = {
			{ "<leader>fr", function() 	require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
}
