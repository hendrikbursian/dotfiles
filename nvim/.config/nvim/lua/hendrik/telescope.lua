-- Inspiration: https://github.com/ThePrimeagen/.dotfiles

local actions = require("telescope.actions")

require("telescope").setup{
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("dap")

local M = {}

-- 'git_files' if repo 'find_files' otherwise
function M.project_files()
    local opts = { hidden = true }
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

M.search_naturallife = function()
	require("telescope.builtin").git_files({
		prompt_title = "< Naturallife Plugin >",
		cwd = "/home/hendrik/workspace/naturallife.gmbh/app/public/wp-content/plugins/naturallife",
		hidden = true,
	})
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({
		prompt_title = "< Dotfiles >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

return M

