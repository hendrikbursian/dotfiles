
local M = {}

-- 'git_files' if repo 'find_files' otherwise
function M.project_files()
    local opts = {
        hidden = true,
        no_ignore = true,
    }
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

M.search_naturallife = function()
    require("telescope.builtin").git_files({
        prompt_title = "< Naturallife Plugin >",
        cwd = "/home/hendrik/workspace/naturallife.gmbh/app/public/wp-content/plugins/naturallife",
        hidden = true,
        no_ignore = true,
    })
end

M.search_dotfiles = function()
    require("telescope.builtin").git_files({
        prompt_title = "< Dotfiles >",
        cwd = vim.env.DOTFILES,
        hidden = true,
        no_ignore = true,
    })
end

return M

