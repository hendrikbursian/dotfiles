-- Autocomplete brackets for method
return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		fast_wrap = {},
	},
	config = function(_, opts)
		require("nvim-autopairs").setup(opts)

		local cmp_ok, cmp = pcall(require, "cmp")
		if cmp_ok then
			local autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", autopairs.on_confirm_done())
		end
	end,
}
