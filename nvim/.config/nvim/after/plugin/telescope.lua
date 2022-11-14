-- Inspiration: https://github.com/ThePrimeagen/.dotfiles
local ok, _ = pcall(require, "telescope")
if not ok then
    return
end

local actions = require("telescope.actions")
local themes = require("telescope.themes")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")

local highlight_filesize_limit = 1000 * 1024 -- 1MB
local bad_files = function(filepath)
    local stat = vim.loop.fs_stat(filepath)

    if stat.size > highlight_filesize_limit then
        return true
    end

    return false
end

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}
    if opts.use_ft_detect == nil then opts.use_ft_detect = true end

    if opts.use_ft_detect == true then
        opts.use_ft_detect = not bad_files(filepath)
    end

    previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup {
    defaults = themes.get_ivy({
        file_sorter = sorters.get_fzy_sorter,
        buffer_previewer_maker = new_maker,

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
