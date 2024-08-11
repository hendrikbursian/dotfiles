return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		opts = {
			max_lines = 1000,
			max_num_results = 20,
			sort = true,
			run_on_every_keystroke = true,
			snippet_placeholder = "..",
		},
		config = function(_, opts)
			require("cmp_tabnine.config"):setup(opts)
		end,
	},
	opts = function(_, opts)
		local tabnine_compare = require("cmp_tabnine.compare")

		table.insert(opts.sorting.comparators, 0, tabnine_compare)
		table.insert(opts.sources, 1, {
			name = "cmp_tabnine",
			group_index = 1,
			priority = 100,
		})
	end,
}
