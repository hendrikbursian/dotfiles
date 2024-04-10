local utils = require("hendrik.utils")

local function setup_dap_typescript()
	local dap = require("dap")
	if not dap.adapters["pwa-node"] then
		require("dap").adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					require("mason-registry").get_package("js-debug-adapter"):get_install_path()
						.. "/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}
	end
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
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach (Yarn Workspace)",
					port = function()
						return vim.fn.input({
							prompt = "Port> ",
							default = "9229",
						})
					end,
					processId = function()
						return require("dap.utils").pick_process({ filter = "yarn" })
					end,
					cwd = function()
						local utils = require("hendrik.utils")

						local file_name = vim.api.nvim_buf_get_name(0)
						local cwd = utils.find_package_json_ancestor(file_name)

						return cwd
					end,
				},
			}
		end
	end
end

return {
	-- Debugging
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			-- Better picker
			{
				"nvim-telescope/telescope-dap.nvim",
				dependencies = "nvim-telescope/telescope.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},

			-- Remember breakpoints
			{
				"Weissle/persistent-breakpoints.nvim",
				event = "VeryLazy",
                -- stylua: ignore
				keys = {
					{ "<leader>bb", function() require("persistent-breakpoints.api").toggle_breakpoint() end, },
					{ "<leader>bc", function() require("persistent-breakpoints.api").set_conditional_breakpoint() end, },
					{ "<leader>bD", function() require("persistent-breakpoints.api").clear_all_breakpoints() end, },
				},
				opts = {
					load_breakpoints_event = { "BufReadPost" },
				},
			},

			-- mason.nvim integration
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
                -- stylua: ignore
				keys = {
					{ "<F5>", function() require("dap").continue() end, },
					{ "<F6>", function() require("dap").step_over() end, },
					{ "<F7>", function() require("dap").step_into() end, },
					{ "<F8>", function() require("dap").repl.toggle() end, },
					-- { "<leader>b", function() require('dap').toggle_breakpoint() end },
				},
				opts = {
					-- Makes a best effort to setup the various debuggers with
					-- reasonable debug configurations
					automatic_installation = true,

					-- You can provide additional configuration to the handlers,
					-- see mason-nvim-dap README for more information
					handlers = {},

					-- You'll need to check that you have the required things installed
					-- online, please don't ask me how to install them :)
					ensure_installed = {
						"js-debug-adapter",
					},
				},
			},

			-- fancy UI for the debugger
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"mfussenegger/nvim-dap",
					"nvim-neotest/nvim-nio",
				},
                -- stylua: ignore
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
				opts = {},
				config = function(_, opts)
					-- setup dap config by VsCode launch.json file
					-- require("dap.ext.vscode").load_launchjs()
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.after.event_breakpoint["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
			},

			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				config = true,
			},
		},
		opts = function()
			setup_dap_typescript()
		end,
		config = function()
			local Config = require("lazyvim.config")
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

			for name, sign in pairs(Config.icons.dap) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define(
					"Dap" .. name,
					{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end
		end,
	},
}
