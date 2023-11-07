local utils = require("hendrik.utils")

return {
	-- Awesome git bindings
	{
		"tpope/vim-fugitive",
        -- stylua: ignore
		keys = {
			{ "<leader>gs", ":Git<CR>",                                      silent = true                                 },
			{ "<leader>gl", ":Git pull<CR>",                                 silent = true                                 },
			{ "<leader>gt", ":Git mergetool<CR>",                            silent = true                                 },
			{ "<leader>gp", ":Git push<CR>",                                 silent = true                                 },
			{ "<leader>gf", ":Git push --force-with-lease<CR>",              silent = true                                 },
			{ "<leader>gF", ":Git push --force<CR>",                         silent = true                                 },
			{ "<leader>go", ":Git log<CR>",                                  silent = true                                 },
            -- TODO: Check this
			{ "<leader>gh", ":GcLog<CR>",                                    silent = true, mode = "v"                     },
			{ "<leader>gW", ":Gwrite<CR>",                                   silent = true                                 },
			{ "<leader>gu", ":Git undo<CR>",                                 silent = true                                 },

			{ "cn",         ":Git commit --no-verify<CR>",                   silent = true, buffer = true, ft = "fugitive" },
			{ "an",         ":Git commit --amend --no-verify<CR>",           silent = true, buffer = true, ft = "fugitive" },
			{ "ae",         ":Git commit --amend --no-verify --no-edit<CR>", silent = true, buffer = true, ft = "fugitive" },
		},
	},

	{
		-- "ThePrimeagen/git-worktree.nvim",

		-- Using fixed version until PR is merged: https://github.com/ThePrimeagen/git-worktree.nvim/pull/106
		"brandoncc/git-worktree.nvim",
		branch = "catch-and-handle-telescope-related-error",

		dependencies = { "nvim-telescope/telescope.nvim" },
        -- stylua: ignore 
		keys = {
			{ "<leader>gw", function() require("telescope").extensions.git_worktree.git_worktrees() end, },
			{ "<leader>gc", function() require("telescope").extensions.git_worktree.create_git_worktree() end, },
		},
		opts = {
			--    change_directory_command = <str> -- default: "cd",
			--    update_on_change = <boolean> -- default: true,
			--    update_on_change_command = <str> -- default: "e .",
			--    clearjumps_on_change = <boolean> -- default: true,
			--    autopush = <boolean> -- default: false,
		},
		config = function(_, opts)
			require("git-worktree").setup(opts)

			-- local Worktree = require("git-worktree")
			-- op = Operations.Switch, Operations.Create, Operations.Delete
			-- metadata = table of useful values (structure dependent on op)
			--      Switch
			--          path = path you switched to
			--          prev_path = previous worktree path
			--      Create
			--          path = path where worktree created
			--          branch = branch name
			--          upstream = upstream remote name
			--      Delete
			--          path = path where worktree deleted

			-- Worktree.on_tree_change(function(op, metadata)
			--     if op == Worktree.Operations.Switch then
			--         print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
			--         -- elseif op == Worktree.Operations.Create then
			--     end
			-- end)

			require("telescope").load_extension("git_worktree")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = utils.FileEvent,
		opts = {
			current_line_blame = true,

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local map = function(mode, l, r, opts)
					local opts = opts or {}
					opts.buffer = bufnr

					if opts.desc then
						opts.desc = "GitSigns: " .. opts.desc
					end

					vim.keymap.set(mode, l, r, opts)
				end

                -- stylua: ignore start
				-- Navigation
				map("n", "]c", function() if vim.wo.diff then return "]c" end vim.schedule(function() gitsigns.next_hunk() end) return "<Ignore>" end, { expr = true })
				map("n", "[c", function() if vim.wo.diff then return "[c" end vim.schedule(function() gitsigns.prev_hunk() end) return "<Ignore>" end, { expr = true })

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk,                                                         { desc = "Stage Hunk" })
				map("n", "<M-S>",      gitsigns.stage_hunk,                                                         { desc = "Stage Hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk,                                                         { desc = "Reset Hunk" })
				map("n", "<M-R>",      gitsigns.reset_hunk,                                                         { desc = "Reset Hunk" })
				map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,  { desc = "Stage Hunk" })
				map("v", "<M-S>",      function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,  { desc = "Stage Hunk" })
				map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,  { desc = "Reset Hunk" })
                map("v", "<M-R>",      function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,  { desc = "Reset Hunk" })

				map("n", "<leader>hS", gitsigns.stage_buffer,                                                       { desc = "Stage Buffer" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk,                                                    { desc = "Undo stage Buffer" })
				map("n", "<leader>hR", gitsigns.reset_buffer,                                                       { desc = "Reset Buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk,                                                       { desc = "Preview Hunk" })
				map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end,                         { desc = "Blame Line" })
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame,                                          { desc = "Blame Line" })
				map("n", "<leader>hd", gitsigns.diffthis,                                                           { desc = "Diff" })
				map("n", "<leader>hD", function() gitsigns.diffthis("~") end,                                       { desc = "Diff to last commit" })
				map("n", "<leader>gd", gitsigns.toggle_deleted,                                                     { desc = "Toggle (show) [d]eleted lines" })
				-- stylua: ignore end
			end,
		},
	},
}
