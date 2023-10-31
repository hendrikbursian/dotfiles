local utils = require("hendrik.utils")

return {
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"telescope.nvim",
		},
        -- stylua: ignore
		keys = {
            { "<leader>re",  function() require("refactoring").refactor("Extract Function") end,         mode = "x" },
            { "<leader>rf",  function() require("refactoring").refactor("Extract Function To File") end, mode = "x" },
            { "<leader>rv",  function() require("refactoring").refactor("Extract Variable") end,         mode = "x" },
            { "<leader>rI",  function() require("refactoring").refactor("Inline Function") end,          mode = "n" },
            { "<leader>ri",  function() require("refactoring").refactor("Inline Variable") end,          mode = { "n", "x" } },
            { "<leader>rb",  function() require("refactoring").refactor("Extract Block") end,            mode = "n" },
            { "<leader>rbf", function() require('refactoring').refactor('Extract Block To File') end,    mode = "n" },
            { "<leader>rr",  function() require("telescope").extensions.refactoring.refactors() end,     mode = { "n", "x" } }
		},
		config = function()
			require("refactoring").setup()
			require("telescope").load_extension("refactoring")
		end,
	},

	-- Advanced substitute
	{
		"tpope/vim-abolish",
		cmd = "Subvert",
	},

	-- Autocomplete brackets for method
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)

			local cmp_ok, cmp = pcall(require, "cmp")
			if cmp_ok then
				local autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", autopairs.on_confirm_done())
			end
		end,
	},

	-- Better search hightlights
	{
		"junegunn/vim-slash",
		event = utils.FileEvent,
		keys = {
			{ "<Plug>(slash-after)", "zz" },
		},
	},

	{
		"numToStr/Comment.nvim",
		keys = {
			{ "gb" },
			{ "gbc" },
			{ "gc" },
			{ "gcc" },
			{ "gb", mode = { "n", "v" } },
			{ "gc", mode = { "n", "v" } },
		},
		opts = {
			ignore = "^$",
		},
	},

	-- Clipboard
	{
		"svermeulen/vim-yoink",
		event = utils.FileEvent,
		keys = {
			{ "<leader>n", "<plug>(YoinkPostPasteSwapBack)" },
			{ "<leader>p", "<plug>(YoinkPostPasteSwapForward)" },

			{ "p", "<plug>(YoinkPaste_p)" },
			{ "P", "<plug>(YoinkPaste_P)" },

			-- default gp with yoink paste so we can toggle paste in this case too
			{ "gp", "<plug>(YoinkPaste_gp)" },
			{ "gP", "<plug>(YoinkPaste_gP)" },
		},
		config = function()
			vim.g.yoinkSavePersistently = true
			vim.g.yoinkSyncSystemClipboardOnFocus = true
			vim.g.yoinkIncludeDeleteOperations = true
			vim.g.yoinkMaxItems = 30

			-- vim.opt.clipboard = 'unnamedplus'
		end,
	},

	-- Multi Cursor
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = utils.FileEvent,
		config = function()
			vim.g.VM_mouse_mappings = 1
			vim.g.VM_maps.Undo = "u"
			vim.g.VM_mapsRedo = "<C-r>"
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},

        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true,
                silent = true,
                mode = "i",
            },
            { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		version = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-calc",
			"saadparwaiz1/cmp_luasnip",

			{
				"David-Kunz/cmp-npm",
				config = true,
			},
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_compare = require("cmp.config.compare")
			local luasnip = require("luasnip")

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},

				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),

					-- TAB: Replace
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Replace,
								select = true,
							})
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-Space>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							cmp.complete()
						end
					end, { "i", "s" }),

					-- Enter: Insert
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({
								behavior = cmp.ConfirmBehavior.Insert,
								select = true,
							})
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sorting = {
					priority_weight = 2,
					comparators = {
						cmp_compare.offset,
						cmp_compare.exact,
						cmp_compare.score,
						cmp_compare.recently_used,
						cmp_compare.kind,
						cmp_compare.sort_text,
						cmp_compare.length,
						cmp_compare.order,
					},
				},

				formatting = {
					format = function(_, item)
						local icons = require("lazyvim.config").icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,

					-- format = function(entry, vim_item)
					--     -- Icons
					--     vim_item.kind = string.format("%s %s", cmp_kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

					--     -- Source
					--     vim_item.menu = ({
					--         copilot = "[Copilot]",
					--         cmp_tabnine = "[Tabnine]",
					--         buffer = "[Buffer]",
					--         nvim_lsp = "[LSP]",
					--         luasnip = "[LuaSnip]",
					--         nvim_lua = "[Lua]",
					--         latex_symbols = "[Latex]",
					--     })[entry.source.name]

					--     return vim_item
					-- end
				},

				-- Sources
				sources = {
					{ name = "path" },
					{ name = "npm", keyword_length = 4 },
					{ name = "calc" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer", keyword_length = 2, max_item_count = 7 },
				},

				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")

			for _, source in ipairs(opts.sources) do
				source.group_index = source.group_index or 1
			end

			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer", keyword_length = 4 },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},

	{ import = "plugins.coding.ai.sourcegraph" },
	-- { import = "plugins.coding.ai.copilot" },
	-- { import = "plugins.coding.ai.tabnine" },
	{ import = "plugins.coding" },
}
