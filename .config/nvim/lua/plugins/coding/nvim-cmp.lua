-- Autocompletion
return {
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

				["<c-x>"] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = "cody" },
						},
					},
				}),

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

				["<C-Space>"] = cmp.mapping(function()
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
				--         cody = "[cody]",
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
				-- { name = "cody" },
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
}
