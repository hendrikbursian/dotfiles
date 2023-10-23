-- Cursor
vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "red" })
vim.api.nvim_set_hl(0, "iCursor", { fg = "white", bg = "red" })

-- Column indicators
-- vim.api.nvim_set_hl("ColorColumn", { ctermbg = 0, bg = "red" }, false)

-- Completion
-- Remove background from floating menu (better visibility)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Grey
vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })

-- Blue
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { bg = "NONE", fg = "#569CD6" })

-- Light blue
vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { bg = "NONE", fg = "#9CDCFE" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { bg = "NONE", fg = "#9CDCFE" })

-- Pink
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { bg = "NONE", fg = "#C586C0" })

-- Front
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { bg = "NONE", fg = "#D4D4D4" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { bg = "NONE", fg = "#D4D4D4" })

