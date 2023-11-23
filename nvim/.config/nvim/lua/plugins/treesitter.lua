local utils = require("hendrik.utils")

return {
	-- Backticks as text-object
	{
		"keaising/textobj-backtick.nvim",
		event = utils.FileEvent,
		config = true,
	},

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		dependencies = {
			-- Additional text objects via treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			sync_install = false,

			ensure_installed = {
				"bash",
				"go",
				"javascript",
				"lua",
				"markdown",
				"markdown_inline",
				"regex",
				"rust",
				"templ",
				"typescript",
				"vim",
				"vue",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<m-space>",
					node_incremental = "<m-space>",
					scope_incremental = "<c-s>",
					node_decremental = "<m-backspace>",
					-- node_decremental = "<c-backspace>",
				},
			},

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
			auto_install = true,

			indent = {
				enable = true,
			},

			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = false, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>l"] = "@parameter.inner",
					},
					-- swap_previous = {
					--     ["<leader>h"] = "@parameter.inner",
					-- },
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		end,
	},

	-- Context lines
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = utils.FileEvent,
		opts = {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			throttle = true, -- Throttles plugin updates (may improve performance)
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			show_all_context = false,
			patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
				-- For all filetypes
				-- Note that setting an entry here replaces all other patterns for this entry.
				-- By setting the "default" entry below, you can control which nodes you want to
				-- appear in the context window.
				default = {
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
				},

				rust = {
					"loop_expression",
					"impl_item",
				},

				typescript = {
					"class_declaration",
					"abstract_class_declaration",
					"else_clause",
				},
			},
		},
		config = function(_, opts)
			function ContextSetup(show_all_context)
				opts.show_all_context = show_all_context
				require("treesitter-context").setup(opts)
			end

			vim.keymap.set("n", "<leader>cf", function()
				ContextSetup(true)
			end)
			vim.keymap.set("n", "<leader>cp", function()
				ContextSetup(false)
			end)
			ContextSetup(false)
		end,
	},
}
