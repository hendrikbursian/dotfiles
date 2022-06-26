local Remap = require("hendrik.keymap")
local nnoremap = Remap.nnoremap

require("git-worktree").setup({
--    change_directory_command = <str> -- default: "cd",
--    update_on_change = <boolean> -- default: true,
--    update_on_change_command = <str> -- default: "e .",
--    clearjumps_on_change = <boolean> -- default: true,
--    autopush = <boolean> -- default: false,
})

nnoremap("<leader>gw", function()
    require("telescope").extensions.git_worktree.git_worktrees()
end)

nnoremap("<leader>gm", function()
    require("telescope").extensions.git_worktree.create_git_worktree()
end)
