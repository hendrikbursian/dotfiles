local banned_messages = {
	"No LSP References found",
	"Request textDocument/prepareRename failed with message: You cannot rename this element.",
}

return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss all Notifications",
		},
	},
	opts = {
		timeout = 5000,
		render = "simple",
		stages = "static",
		-- top_down = false,
		-- background_colour = "#000000",
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		on_open = function(win)
			vim.api.nvim_win_set_config(win, { zindex = 100 })
		end,
	},
	init = function()
		vim.notify = function(msg, ...)
			for _, banned_msg in ipairs(banned_messages) do
				if string.find(msg, banned_msg) then
					vim.print(msg, ...)
					return
				end
			end
			require("notify")(msg, ...)
		end
	end,
}
