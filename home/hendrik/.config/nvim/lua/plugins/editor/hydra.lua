local state = {
	active = false,
	name = nil,
    color = nil
}

local colors = {
    red	= "#ff5733",
    blue = "#5ebcf6",
    amaranth = "#ff1757",
    teal = "#00a1a1",
    pink = "#ff55de",
}


return {
	{
		"anuvyklack/hydra.nvim",
		dependencies = {
			"nvim-dap",
			{
				"nvim-lualine/lualine.nvim",
				opts = function(_, opts)
                    opts.sections = {
                        lualine_a = {
                            {
                                "mode",
                                cond = function ()
                                    return not state.active
                                end
                            },
                            {
                                function ()
                                    return state.name
                                end,
                                cond = function ()
                                    return state.active
                                end,
                                color = function ()
                                    if state.color == nil then
                                        return { bg = colors.red }
                                    end

                                    return { bg = colors[state.color] }
                                end
                            },
                        },
                    }

					return opts
				end,
			},
		},
		config = function()
            local hydra_layer = require("hydra.layer")
			local m = { "n", "x" } -- modes
			local dap_keys = hydra_layer({
				enter = {
			                 -- TODO: make this only work when Dap is active
			                 { m,          "<leader>db", nil,                                                 { desc = "enter debug mode"      } },
			             },

				layer = {
			                 { m,          "<leader>dc", function() require("dap").continue()            end, { desc = "debug continue "      } },
			                 { m,          "<leader>dC", function() require("dap").run_to_cursor()       end, { desc = "debug Cursor"         } },
			                 { m,          "<leader>dg", function() require("dap").goto()                end, { desc = "debug go to line"     } },
			                 { m,          "<leader>dn", function() require("dap").step_over()           end, { desc = "debug step over next" } },
			                 { m,          "<leader>dN", function() require("dap").step_back()           end, { desc = "debug step back Next" } },
			                 { m,          "<leader>do", function() require("dap").step_out()            end, { desc = "debug step out"       } },
			                 { m,          "<leader>di", function() require("dap").step_into()           end, { desc = "debug step into"      } },
			                 { m,          "<leader>dj", function() require("dap").down()                end, { desc = "debug frame down"     } },
			                 { m,          "<leader>dk", function() require("dap").up()                  end, { desc = "debug frame up"       } },
			                 { m,          "<leader>dl", function() require("dap").run_last()            end, { desc = "debug last"           } },
			                 { m,          "<leader>dp", function() require("dap").pause()               end, { desc = "debug pause"          } },
			                 { m,          "<leader>dr", function() require("dap").repl.toggle()         end, { desc = "debug repl"           } },
			                 { m,          "<leader>dR", function() require("dap").restart()             end, { desc = "debug Restart"        } },
			                 { m,          "<leader>ds", function() require("dap").session()             end, { desc = "debug session"        } },
			                 { m,          "<leader>dT", function() require("dap").terminate()           end, { desc = "debug Terminate"      } },
			                 { {"n", "v"}, "<leader>de", function() require("dap.ui.widgets").hover()    end, { desc = "debug eval"           } },

			                 { m,          "g",          function() require("dap").goto()                end, { desc = "debug go to line"     } },
			                 { m,          "n",          function() require("dap").step_over()           end, { desc = "debug step over next" } },
			                 { m,          "N",          function() require("dap").step_back()           end, { desc = "debug step back Next" } },
			                 { m,          "c",          function() require("dap").continue()            end, { desc = "debug continue"       } },
			                 { m,          "C",          function() require("dap").run_to_cursor()       end, { desc = "debug Cursor"         } },
			                 { m,          "i",          function() require("dap").step_into()           end, { desc = "debug step into"      } },
			                 { m,          "o",          function() require("dap").step_out()            end, { desc = "debug step out"       } },
			                 { m,          "R",          function() require("dap").restart()             end, { desc = "debug Restart"        } },
			                 { m,          "T",          function() require("dap").terminate()           end, { desc = "debug Terminate"      } },
			                 { {"n", "v"}, "e",          function() require("dap.ui.widgets").hover()    end, { desc = "debug eval/inspect"   } },

			                 { m,          "u",          function() require("dapui").toggle({})          end, { desc = "Dap UI"               } },
			                 { m,          "v",          function() require("dapui").float_element("scopes", { enter = true, title = "Scopes", width = 92, height = 20}) end, { desc = "Debug variables" } },
				},

				exit = {
			                 { m,          "<leader>db", nil,                                                 { desc = "exit debug mode"      } },
			                 { m,          "q"         , nil,                                                 { desc = "exit debug mode"      } },
			             },

				config = {
					on_enter = function()
						vim.bo.modifiable = false
                        state.name = "DEBUG"
                        state.active = true
                        state.color = "pink"
					end,
					on_exit = function()
                        state.active = false
                        state.name = nil
                        state.color = nil
					end,
				},
			})

			local dap = require("dap")

			dap.listeners.after["event_initialized"]["keymap-dap"] = function()
				dap_keys:activate()
			end

			dap.listeners.after["event_stopped"]["keymap-dap"] = function(_, body)
			             if body.reason == "breakpoint" or
			                 body.reason =='function breakpoint' or
			                 body.reason =='data breakpoint' or
			                 body.reason =='instruction breakpoint' then

			                 dap_keys:activate()
			             end
			end

			dap.listeners.before["event_terminated"]["keymap-dap"] = function()
				dap_keys:exit()
			end
		end,
	},
}
