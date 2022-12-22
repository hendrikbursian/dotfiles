local ok, git_worktree = pcall(require, "git-worktree")
if not ok then
    return
end

git_worktree.setup({
    --    change_directory_command = <str> -- default: "cd",
    --    update_on_change = <boolean> -- default: true,
    --    update_on_change_command = <str> -- default: "e .",
    --    clearjumps_on_change = <boolean> -- default: true,
    --    autopush = <boolean> -- default: false,
})

local Worktree = require("git-worktree")

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

Worktree.on_tree_change(function(op, metadata)

    -- P(op)
    -- P(metadata)
    -- P("----------------------------")

    if op == Worktree.Operations.Switch then
        print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
        -- elseif op == Worktree.Operations.Create then
    end
end)

vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees)
vim.keymap.set("n", "<leader>gc", require("telescope").extensions.git_worktree.create_git_worktree)
