-- database management
return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod" },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
		{ "hrsh7th/nvim-cmp" },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>db", "<cmd>DBUI<cr>" },
	},
	init = function()
		vim.g.db_ui_show_help = 1
		-- vim.g.db_ui_win_position = "right"
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_use_nvim_notify = 0

		vim.g.db_ui_save_location = os.getenv("XDG_CONFIG_HOME") .. "/.dbui"
		vim.g.db_ui_tmp_query_location = os.getenv("XDG_CACHE_HOME") .. "/dbui_queries"

		vim.g.db_ui_hide_schemas = { "pg_toast_temp.*", "postgres", "pg_toast", "information_schema", "pg_catalog" }
	end,
	config = function()
		local group = vim.api.nvim_create_augroup("config_vim_dadbod_completion", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				require("cmp").setup.buffer({
					sources = {
						{ name = "vim-dadbod-completion" },
						{ name = "buffer" },
						{ name = "vsnip" },
					},
				})
			end,
		})
	end,
}
