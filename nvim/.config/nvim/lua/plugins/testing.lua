return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim"
        },
        opts = {
            adapters = {},
            status = { virtual_text = true },
            output = { open_on_run = true },
        },
        config = function(_, opts)
            vim.print(opts)

            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        -- Replace newline and tab characters with space for more compact diagnostics
                        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+",
                            "")
                        return message
                    end,
                },
            }, neotest_ns)

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
        -- stylua: ignore
        keys = {
            { "<leader>tt", function() require("neotest").run.run() end,                             desc = "Run Nearest" },
            {
                "<leader>tT",
                function() require("neotest").run.run(vim.loop.cwd()) end,
                desc = "Run All Test Files"
            },
            { "<leader>tf", function() require("neotest").run.run(vim.api.nvim_buf_get_name(0)) end, desc = "Run File" },
            { "<leader>tl", function() require("neotest").run.run_last() end },
            {
                "<leader>te",
                function() require("neotest").summary.toggle() end,
                desc = "Test Explorer"
            },

            {
                "<leader>ts",
                function() require("neotest").summary.toggle() end,
                desc = "Toggle Summary"
            },
            {
                "<leader>to",
                function() require("neotest").output.open({ enter = true, auto_close = true }) end,
                desc = "Show Output"
            },
            {
                "<leader>tO",
                function() require("neotest").output_panel.toggle() end,
                desc = "Toggle Output Panel"
            },
            {
                "<leader>tS",
                function() require("neotest").run.stop() end,
                desc = "Stop"
            },
        },
    },

    {
        "mfussenegger/nvim-dap",
        optional = true,
        -- stylua: ignore
        keys = {
            { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug Nearest" },
        },
    },

    {
        "nvim-neotest/neotest",
        dependencies = { "haydenmeade/neotest-jest" },
        opts = function()
            return {
                adapters = {
                    require("neotest-jest")({}),
                }
            }
        end
    },
}
