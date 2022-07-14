local M = {}

M.project_files = function()
    local opts = {
        hidden = true,
        no_ignore = true,
        show_untracked = true,
    }

    -- naturallife plugin folder
    local path = vim.fn.getcwd()
    if string.find(path, "naturallife") then
        opts.cwd = '/home/hendrik/workspace/naturallifegmbh/app/public/wp-content/plugins/naturallife'
    end

    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

M.search_dotfiles = function()
    require("telescope.builtin").git_files({
        prompt_title = "< Dotfiles >",
        cwd = vim.env.DOTFILES,
        hidden = true,
        no_ignore = true,
        show_untracked = true,
    })
end

return M
