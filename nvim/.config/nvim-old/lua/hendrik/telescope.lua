local M = {}

M.git_files = function()
    require("telescope.builtin").git_files({
        hidden = true,
        no_ignore = true,
        show_untracked = true
    })
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

M.grep_clipboard = function()
    local search = ""

    local file = io.popen("xsel -b", "r")

    if file then
        search = file:read("*a")
        file:close()
    end

    require("telescope.builtin").grep_string({
        search = search
    })
end

M.lsp_references = function()
    require("telescope.builtin").lsp_references({
        fname_width = 60
    })
end

M.find_files = function()
    require("telescope.builtin").find_files({
        hidden = true,
        no_ignore = true
    })
end

return M
