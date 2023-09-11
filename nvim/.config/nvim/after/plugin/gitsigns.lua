local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns.setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, opts)
            local opts = opts or {}
            opts.buffer = bufnr

            if opts.desc then
                opts.desc = "GitSigns: " .. opts.desc
            end

            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "[S]tage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "[R]eset Hunk" })
        map("v", "<leader>hs", function()
                gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
            end,
            { desc = "[S]tage Hunk" }
        )
        map("v", "<leader>hr", function()
                gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
            end,
            { desc = "[R]eset Hunk" }
        )
        map("n", "<leader>hS", gs.stage_buffer, { desc = "[S]tage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[U]ndo stage Buffer" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "[R]eset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "[P]review Hunk" })
        map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "[B]lame Line" })
        map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "[B]lame Line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "[D]iff" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "[D]iff to last commit" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "[T]oggle (show) [d]eleted lines" })
    end
})
