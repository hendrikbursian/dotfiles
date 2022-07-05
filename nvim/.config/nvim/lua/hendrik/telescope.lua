print("Loading hendrik.telescope")

local M = {}

-- 'git_files' if repo 'find_files' otherwise
function M.project_files()
    local opts = {
        hidden = true,
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

local function open_telescope_oldfiles()
    -- Check for file
    if next(vim.fn.argv()) == nil then
        require("telescope.builtin").oldfiles({ only_cwd = true })
    end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = open_telescope_oldfiles
})

return M
