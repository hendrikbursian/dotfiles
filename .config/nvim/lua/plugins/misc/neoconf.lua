return {
	"folke/neoconf.nvim",
	lazy = false,
	config = function()
		require("neoconf").setup()

		require("neoconf.plugins").register({
			on_schema = function(schema)
				schema:set("quick_files.1", { description = "Path to file 1", type = "string" })
				schema:set("quick_files.2", { description = "Path to file 2", type = "string" })
				schema:set("quick_files.3", { description = "Path to file 3", type = "string" })
				schema:set("quick_files.4", { description = "Path to file 4", type = "string" })
				schema:set("quick_files.5", { description = "Path to file 5", type = "string" })
				schema:set("quick_files.7", { description = "Path to file 7", type = "string" })
			end,
		})

		local log_files_config = require("neoconf").get("quick_files")

		if log_files_config == nil then
			vim.print("Missing quick_files config")
			return
		end

		vim.keymap.set("n", "<leader>1", ":edit " .. log_files_config["1"] .. "<cr>")
		vim.keymap.set("n", "<leader>2", ":edit " .. log_files_config["2"] .. "<cr>")
		vim.keymap.set("n", "<leader>3", ":edit " .. log_files_config["3"] .. "<cr>")
		vim.keymap.set("n", "<leader>4", ":edit " .. log_files_config["4"] .. "<cr>")
		vim.keymap.set("n", "<leader>5", ":edit " .. log_files_config["5"] .. "<cr>")
		vim.keymap.set("n", "<leader>7", ":edit " .. log_files_config["7"] .. "<cr>")
	end,
}
