-- Colorscheme
vim.opt.termguicolors = true

-- Define a list of colorschemes
local colorschemes = {
    { schema = 'nord',       background = 'dark' },
    { schema = 'PaperColor', background = 'light' },
}

local current_colorscheme = 0
function cycle_colorschemes(direction)
    if direction == "forward" then
        current_colorscheme = current_colorscheme % #colorschemes + 1
    elseif direction == "backward" then
        current_colorscheme = (current_colorscheme - 2) % #colorschemes + 1
    end
    vim.cmd("colorscheme " .. colorschemes[current_colorscheme].schema)
    vim.opt.background = colorschemes[current_colorscheme].background
end

if current_colorscheme == 0 then
    cycle_colorschemes('forward')
end

-- Map the keys to cycle through colorschemes
vim.api.nvim_set_keymap("n", "<leader>c", ":lua cycle_colorschemes('forward')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>C", ":lua cycle_colorschemes('backward')<CR>", { noremap = true, silent = true })

-- local hour = os.date("*t").hour



-- vim.cmd('colorscheme gruvbox')
-- vim.g.gruvbox_italic = 1
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.g.gruvbox_contrast_light = 'soft'
-- vim.opt.background = 'light'

-- Completion


-- Remove background from floating menu (better visibility)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Grey
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })

-- Blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { bg = 'NONE', fg = '#569CD6' })

-- Light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = 'NONE', fg = '#9CDCFE' })

-- Pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { bg = 'NONE', fg = '#C586C0' })

-- Front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { bg = 'NONE', fg = '#D4D4D4' })

-- Cursor
vim.api.nvim_set_hl(0, 'Cursor', { fg = 'white', bg = 'red' })
vim.api.nvim_set_hl(0, 'iCursor', { fg = 'white', bg = 'red' })
vim.opt.guicursor = { 'n-v-c-sm:block-Cursor', 'i-ci-ve:block-Cursor', 'r-cr-o:hor20' }

-- Column indicators
-- vim.api.nvim_set_hl('ColorColumn', { ctermbg = 0, bg = 'red' }, false)
