local function get_neoconf_defaults()
	local dap = require("dap")

	-- extract filetypes from dap.configurations
	local filetypes = {}
	for filetype, _ in pairs(dap.configurations) do
		for _, configuration in ipairs(dap.configurations[filetype]) do
			local adapter = configuration.type

			if not filetypes[adapter] then
				filetypes[adapter] = { filetype }
			elseif not vim.tbl_contains(filetypes[adapter], filetype) then
				table.insert(filetypes[adapter], filetype)
			end
		end
	end

	filetypes = vim.tbl_deep_extend("force", filetypes, {
		["node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
		["pwa-node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
	})

	return {
		adapters = dap.adapters,
		filetypes = filetypes,
	}
end

local function load_vscode_launch_json(dap_settings)
	if vim.fn.filereadable(".vscode/launch.json") then
		local vscode = require("dap.ext.vscode")

		vscode.load_launchjs(nil, dap_settings.filetypes)
	end
end

return {
	{
		"mfussenegger/nvim-dap",

        --stylua: ignore
        keys = {
            { "<F5>", function()
                local dap = require("dap")
                local dap_defaults = get_neoconf_defaults()
                local dap_settings = require("neoconf").get("nvim-dap", dap_defaults)

                -- refresh adapters
                dap.adapters = dap_settings.adapters
                vim.print(dap.adapters)

                load_vscode_launch_json(dap_settings)

                dap.continue()
            end, },
            { "<F6>", function() require("dap").step_over() end, },
            { "<F7>", function() require("dap").step_into() end, },
            { "<F8>", function() require("dap").repl.toggle() end, },

            -- breakpoints
            -- {"<leader>bb", function() require("dap").toggle_breakpoint() end, desc = "toggle de[b]ug [b]reakpoint" },
            -- {"<leader>bB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "de[b]ug [B]reakpoint"},
            -- {"<leader>bR", function() require("dap").clear_breakpoints() end, desc = "de[b]ug [R]emove breakpoints" },

            {"<leader>bc", function() require("dap").continue() end, desc = "de[b]ug [c]ontinue (start here)" },
            {"<leader>bC", function() require("dap").run_to_cursor() end, desc = "de[b]ug [C]ursor" },
            {"<leader>bg", function() require("dap").goto_() end, desc = "de[b]ug [g]o to line" },
            {"<leader>bo", function() require("dap").step_over() end, desc = "de[b]ug step [o]ver" },
            {"<leader>bO", function() require("dap").step_out() end, desc = "de[b]ug step [O]ut" },
            {"<leader>bi", function() require("dap").step_into() end, desc = "de[b]ug [i]nto" },
            {"<leader>bj", function() require("dap").down() end, desc = "de[b]ug [j]ump down" },
            {"<leader>bk", function() require("dap").up() end, desc = "de[b]ug [k]ump up" },
            {"<leader>bl", function() require("dap").run_last() end, desc = "de[b]ug [l]ast" },
            {"<leader>bp", function() require("dap").pause() end, desc = "de[b]ug [p]ause" },
            {"<leader>br", function() require("dap").repl.toggle() end, desc = "de[b]ug [r]epl" },
            {"<leader>bs", function() require("dap").session() end, desc ="de[b]ug [s]ession" },
            {"<leader>bt", function() require("dap").terminate() end, desc = "de[b]ug [t]erminate" },
            {"<leader>bw", function() require("dap.ui.widgets").hover() end, desc = "de[b]ug [w]idgets" },
        },
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

			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end

			local dap_defaults = get_neoconf_defaults()

			-- register your settings schema with Neodev, so auto-completion will work in the json files
			require("neoconf.plugins").register({
				on_schema = function(schema)
					-- this call will create a json schema based on the lua types of your default settings
					schema:import("nvim-dap", dap_defaults)
					-- Optionally update some of the json schema
					-- schema:set("nvim-dap.type", {
					-- 	description = "Special array containg booleans or numbers",
					-- 	type = "string",
					-- })
					-- schema:set("nvim-dap.port", {
					-- 	description = "Special array containg booleans or numbers",
					-- 	type = "number",
					-- })
					-- schema:set("nvim-dap.args", {
					-- 	description = "Special array containg booleans or numbers",
					-- 	anyOf = {
					-- 		{ type = "string" },
					-- 	},
					-- })
				end,
			})
		end,
	},

	{ import = "plugins.debugging" },
	{ import = "plugins.debugging.lang.go" },
	{ import = "plugins.debugging.lang.typescript" },
}
