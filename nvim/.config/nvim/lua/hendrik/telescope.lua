local utils = require("hendrik.utils")

local M = {}

M.live_grep = function(opts)
	require("telescope.builtin").live_grep(vim.tbl_deep_extend("force", opts or {}, {
		cwd = utils.get_git_dir_or_cwd(),
		hidden = true,
		no_ignore = true,
	}))
end

M.find_files = function(opts)
	require("telescope.builtin").find_files(vim.tbl_deep_extend("force", opts or {}, {
		cwd = utils.get_git_dir_or_cwd(),
		hidden = true,
		no_ignore = true,
	}))
end

M.git_files = function(opts)
	local path = utils.get_current_file_or_cwd()
	local git_dir = utils.find_git_ancestor(path)

	if git_dir ~= nil then
		require("telescope.builtin").git_files(vim.tbl_deep_extend("force", opts or {}, {
			hidden = false,
			no_ignore = true,
			show_untracked = true,
			cwd = git_dir,
		}))
	else
		M.find_files(opts)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({
		prompt_title = "< Dotfiles >",
		cwd = vim.env.DOTFILES,
		hidden = true,
		no_ignore = false,
		show_untracked = true,
	})
end

M.grep_clipboard = function()
	local search = ""

	local file = io.popen("xsel -b", "r")

	if file then
		search = file:read("*a")
		file:close()
	end

	require("telescope.builtin").grep_string({
		search = search,
	})
end

M.lsp_references = function(opts)
	require("telescope.builtin").lsp_references(vim.tbl_deep_extend("force", opts or {}, {
		file_ignore_patterns = { "%.spec.ts" },
		jump_type = "split",
		fname_width = 60,
	}))
end

return M
