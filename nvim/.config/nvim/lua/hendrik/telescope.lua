-- Inspiration: https://github.com/ThePrimeagen/.dotfiles

local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values

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
				-- ["<Esc>"] = actions.close,
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},

            -- TODO: doesnt work!
            -- n = {
            --     ["cd"] = function(prompt_bufnr)
            --         local selection = require("telescope.actions.state").get_selected_entry()
            --         local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            --         require("telescope.actions").close(prompt_bufnr)
            --         -- Depending on what you want put `cd`, `lcd`, `tcd`
            --         vim.cmd(string.format("lcd %s", dir))
            --     end
            -- },
        },

        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "-g=**/*"
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

local M = {}

-- 'git_files' if repo 'find_files' otherwise
function M.project_files()
    local opts = {} -- define here if you want to define something
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

