-- Inspiration: https://github.com/ThePrimeagen/.dotfiles
local ok, _ = pcall(require, "telescope")
if not ok then
    return
end

local Job = require("plenary.job")

local actions = require("telescope.actions")
local themes = require("telescope.themes")
local sorters = require("telescope.sorters")
local previewers = require('telescope.previewers')

local highlight_max_file_size = 1000 * 1024 -- 1 MB

local preview_maker = function(filepath, bufnr, opts)
    local mime_type = nil

    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            mime_type = vim.split(j:result()[1], "/")[1]
        end
    }):sync()

    -- Filter binary files
    if mime_type ~= "text" then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "[ BINARY ]" })
        return
    end

    opts = opts or {}

    if opts.use_ft_detect == nil then
        opts.use_ft_detect = true
    end

    -- Only use syntax highlighting for files <= highlight_max_file_size
    local stats = vim.loop.fs_stat(filepath)
    opts.use_ft_detect = opts.use_ft_detect == false and false or stats.size <= highlight_max_file_size

    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup {
    defaults = themes.get_ivy({
        file_sorter = sorters.get_fzy_sorter,
        buffer_previewer_maker = preview_maker,
        prompt_prefix = " >",
        color_devicons = true,

        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
            "--hidden",
        },

        path_display = {
            'truncate',
            shorten = 4,
        },

        layout_config = {
            height = 0.5,
        },

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
            n = {
                ["<C-q>"] = actions.send_selected_to_qflist,
            },
        },
    }),

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
