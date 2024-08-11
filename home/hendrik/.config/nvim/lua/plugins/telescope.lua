return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = { "Telescope" },
		dependencies = { "nvim-lua/plenary.nvim" },
        -- stylua: ignore
        keys = {
            { "<leader><space>", function() 	require("telescope.builtin").buffers() end },
            { "<leader>?",       function() 	require("telescope.builtin").oldfiles() end },
            { "<leader>fh",      function() 	require("telescope.builtin").help_tags() end },
            { "<leader>m",       function() 	require("telescope.builtin").filetypes() end },
            { "<leader>gh",      function() 	require("telescope.builtin").git_bcommits() end },
            { "<leader>fd",      function() 	require("telescope.builtin").diagnostics() end },
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            { "<leader>/",       function() 	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end },
            { "<C-p>",       function() 	    require("modules.telescope").git_files() end },
            { "<leader>dot", function() 	    require("modules.telescope").search_dotfiles() end },
            { "<leader>fF",  function() 	    require("modules.telescope").find_files() end },
            { "<leader>ff",  function() 	    require("modules.telescope").find_files({
                glob_pattern = { "!*.spec.*" }
            }) end },
            { "<leader>fG",  function() 	    require("modules.telescope").live_grep() end },
            { "<leader>fg",  function() 	    require("modules.telescope").live_grep({
                glob_pattern = { "!*.spec.*" }
            }) end },
        },
		opts = function()
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")

			local highlight_filesize_limit = 1000 * 1024 -- 1MB
			local bad_files = function(filepath)
				local stat = vim.loop.fs_stat(filepath)

				if stat ~= nil and stat.size > highlight_filesize_limit then
					return true
				end

				return false
			end

			local new_maker = function(filepath, bufnr, opts)
				opts = opts or {}
				if opts.use_ft_detect == nil then
					opts.use_ft_detect = true
				end

				if opts.use_ft_detect == true then
					opts.use_ft_detect = not bad_files(filepath)
				end

				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			end

			return {
				defaults = require("telescope.themes").get_ivy({
					buffer_previewer_maker = new_maker,

					color_devicons = true,

					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--trim",
						"--hidden",
					},

					path_display = {
						"truncate",
						shorten = 4,
					},

					layout_config = {
						height = 0.5,
					},

					mappings = {
						i = {
							["<C-q>"] = actions.send_to_qflist,
						},
						n = {
							["<C-q>"] = actions.send_selected_to_qflist,
						},
					},
				}),
			}
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			return vim.tbl_deep_extend("force", opts, {
				defaults = {
					file_sorter = require("telescope.sorters").get_fzy_sorter,
				},
				extensions = {
					fzy_native = {
						override_generic_sorter = false,
						override_file_sorter = true,
					},
				},
			})
		end,
		dependencies = {
			"nvim-telescope/telescope-fzy-native.nvim",
			config = function()
				require("telescope").load_extension("fzy_native")
			end,
		},
	},
}
