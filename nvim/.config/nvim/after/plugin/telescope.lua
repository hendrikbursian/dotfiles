-- Inspiration: https://github.com/ThePrimeagen/.dotfiles
local ok, telescope = pcall(require, "telescope")
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

    if stat ~= nil and stat.size > highlight_filesize_limit then
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

telescope.setup {
    defaults = themes.get_ivy({
        file_sorter = sorters.get_fzy_sorter,
        buffer_previewer_maker = new_maker,

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
        undo = {
            -- side_by_side = true,
            -- use_delta = false,
        }
    },
}

telescope.load_extension("fzy_native")
telescope.load_extension("git_worktree")
telescope.load_extension("dap")
telescope.load_extension("undo")
