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

-- TODO: Use selection for grep
-- vim.keymap.set("v","<leader>fs", function()
--     local s = vim.fn.getpos(""<")
--     local e = vim.fn.getpos("">")

--     P(s)
--     local line_start = s[2]
--     local line_end = e[2]
--     P(line_start)
--     P(line_end)
--     -- local start_col = s[1]

--     -- local end_col = end[1]

--     vim.fn.getline(line_start, line_end)

--     -- return require("telescope.builtin").grep_string()
-- end)
return M
