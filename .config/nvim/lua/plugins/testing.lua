return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
		},
		opts = {
			adapters = {},
			status = {
				enabled = true,
				signs = true,
				virtual_text = false,
			},
			state = {
				enabled = true,
			},
			diagnostic = {
				enabled = false,
				severity = vim.log.levels.TRACE,
			},
			output = {
				enabled = true,
				open_on_run = true,
			},
			summary = {
				animated = false,
				follow = true,
				expand_errors = true,
			},
		},
        -- stylua: ignore
        keys = {
            { "<leader>ta", function() require("neotest").run.attach() end,                                                      desc = "[t]est [a]ttach" },
            { "<leader>tf", function() require("neotest").run.run(vim.api.nvim_buf_get_name(0)) end,                             desc = "[t]est run [f]ile" },
            { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                                             desc = "[t]est [A]ll files" },
            { "<leader>tS", function() require("neotest").run.run({ suite = true }) end,                                         desc = "[t]est [S]uite" },
            { "<leader>tt", function() require("neotest").run.run() end,                                                         desc = "[t]est [n]earest" },
            { "<leader>tw", function() require("neotest").watch.toggle() end,                                                     desc = "[t]est [w]atch" },
            { "<leader>tl", function() require("neotest").run.run_last() end,                                                    desc = "[t]est [l]ast" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,                                                  desc = "[t]est [s]ummary" },
            { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true, last_run = false}) end, desc = "[t]est [o]utput" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,                                             desc = "[t]est [O]utput panel" },
            { "<leader>tS", function() require("neotest").run.stop() end,                                                        desc = "[t]est [t]erminate" },
            { "<leader>td", function() require("neotest").run.run(vim.fn.expand("%:h")) end,                                     desc = "[t]est [d]irectory" },
            { "<leader>tD", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,                      desc = "[t]est [D]debug" },
        },
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			"fredrikaverpil/neotest-golang",
			dependencies = {
				{
					"leoluz/nvim-dap-go",
					opts = {},
				},
			},
			branch = "main",
		},

		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			opts.adapters["neotest-golang"] = {
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-timeout=60s",
				},
				dap_go_enabled = true,
			}

			return opts
		end,
		config = function(_, opts)
			if opts.adapters then
				local adapters = {}
				for name, config in pairs(opts.adapters or {}) do
					if type(name) == "number" then
						if type(config) == "string" then
							config = require(config)
						end
						adapters[#adapters + 1] = config
					elseif config ~= false then
						local adapter = require(name)
						if type(config) == "table" and not vim.tbl_isempty(config) then
							local meta = getmetatable(adapter)
							if adapter.setup then
								adapter.setup(config)
							elseif meta and meta.__call then
								adapter(config)
							else
								error("Adapter " .. name .. " does not support setup")
							end
						end
						adapters[#adapters + 1] = adapter
					end
				end
				opts.adapters = adapters
			end

			require("neotest").setup(opts)
		end,
	},

	{
		"nvim-neotest/neotest",
		dependencies = {
			{ "nvim-neotest/neotest-jest" },
		},
		opts = function(_, opts)
			opts.adapters["neotest-jest"] = {}
			return opts
		end,
	},

	{
		"nvim-dap",
		optional = true,
        -- stylua: ignore
        keys = {
            { "<leader>tD", function() require("neotest").run.run({ strategy = "dap", suite = false }) end, desc = "Debug Nearest" },
        },
	},
}
