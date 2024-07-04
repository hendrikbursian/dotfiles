return {
	"folke/neoconf.nvim",
	lazy = false,
	config = function()
		require("neoconf").setup()

		require("neoconf.plugins").register({
			on_schema = function(schema)
				schema:set("log_files.daily", { description = "Path to daily log", type = "string" })
				schema:set("log_files.weekly", { description = "Path to weekly log", type = "string" })
				schema:set("log_files.monthly", { description = "Path to montly log", type = "string" })
				schema:set("log_files.yearly", { description = "Path to yearly log", type = "string" })
			end,
		})

		local log_files_config = require("neoconf").get("log_files")

		vim.keymap.set("n", "<leader>1", ":edit " .. log_files_config.daily .. "<cr>")
		vim.keymap.set("n", "<leader>2", ":edit " .. log_files_config.weekly .. "<cr>")
		vim.keymap.set("n", "<leader>3", ":edit " .. log_files_config.monthly .. "<cr>")
		vim.keymap.set("n", "<leader>4", ":edit " .. log_files_config.yearly .. "<cr>")
	end,
}
