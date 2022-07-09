-- Inspiration: https://github.com/ThePrimeagen/.dotfiles
local ok,_ = pcall(require, "telescope")
if not ok then
    return
end

local actions = require("telescope.actions")

require("telescope").setup {
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

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

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
            n = {
                ["<C-q>"] = actions.send_selected_to_qflist,
            },
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
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("dap")
