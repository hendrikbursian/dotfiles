-- Colorscheme
vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.cmd('colorscheme nord')
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme PaperColor')

vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_contrast_light = 'soft'

-- Completion

-- Grey
vim.highlight.create('CmpItemAbbrDeprecated', { guibg = 'NONE', gui = 'strikethrough', guifg = '#808080' }, true)

-- Blue
vim.highlight.create('CmpItemAbbrMatch', { guibg = 'NONE', guifg = '#569CD6' }, true)
vim.highlight.create('CmpItemAbbrMatchFuzzy', { guibg = 'NONE', guifg = '#569CD6' }, true)

-- Light blue
vim.highlight.create('CmpItemKindVariable', { guibg = 'NONE', guifg = '#9CDCFE' }, true)
vim.highlight.create('CmpItemKindInterface', { guibg = 'NONE', guifg = '#9CDCFE' }, true)
vim.highlight.create('CmpItemKindText', { guibg = 'NONE', guifg = '#9CDCFE' }, true)

-- Pink
vim.highlight.create('CmpItemKindFunction', { guibg = 'NONE', guifg = '#C586C0' }, true)
vim.highlight.create('CmpItemKindMethod', { guibg = 'NONE', guifg = '#C586C0' }, true)

-- Front
vim.highlight.create('CmpItemKindKeyword', { guibg = 'NONE', guifg = '#D4D4D4' }, true)
vim.highlight.create('CmpItemKindProperty', { guibg = 'NONE', guifg = '#D4D4D4' }, true)
vim.highlight.create('CmpItemKindUnit', { guibg = 'NONE', guifg = '#D4D4D4' }, true)


-- Cursor
vim.highlight.create('Cursor', { guifg = 'white', guibg = 'red' }, false)
vim.highlight.create('iCursor', { guifg = 'white', guibg = 'red' }, false)
vim.opt.guicursor = { 'n-v-c-sm:block-Cursor', 'i-ci-ve:block-Cursor', 'r-cr-o:hor20' }

-- Column indicators
-- vim.highlight.create('ColorColumn', { ctermbg = 0, guibg = 'red' }, false)
