-- Inspiration: https://github.com/ThePrimeagen/.dotfiles

local actions = require("telescope.actions")

require("telescope").setup{
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

require("telescope").load_extension('fzf')

local M = {}

-- 'git_files' if repo 'find_files' otherwise
function M.project_files()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

M.reload_modules = function()
    local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
	for _, dir in ipairs(lua_dirs) do
		dir = string.gsub(dir, "./lua/", "")
		require("plenary.reload").reload_module(dir)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({
		prompt_title = "< VimRC >",
		cwd = vim.env.DOTFILES,
		hidden = true,
	})
end

return M

