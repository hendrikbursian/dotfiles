return {
	"nvim-dap",
	optional = true,
	opts = function()
		local dap = require("dap")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					-- TODO: use nix for this
					-- require("mason-registry").get_package("js-debug-adapter"):get_install_path()
					-- 	.. "/js-debug/src/dapDebugServer.js",
					-- "${port}",
					"asdfasdfasdfasdf",
				},
			},
		}

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					-- {
					-- 	type = "pwa-node",
					-- 	request = "attach",
					-- 	name = "Attach (Yarn Workspace)",
					-- 	port = function()
					-- 		return vim.fn.input({
					-- 			prompt = "Port> ",
					-- 			default = "9229",
					-- 		})
					-- 	end,
					-- 	processId = function()
					-- 		return require("dap.utils").pick_process({ filter = "yarn" })
					-- 	end,
					-- 	cwd = function()
					-- 		local utils = require("modules.utils")

					-- 		local file_name = vim.api.nvim_buf_get_name(0)
					-- 		local cwd = utils.find_package_json_ancestor(file_name)

					-- 		return cwd
					-- 	end,
					-- },
				}
			end
		end
	end,
}
