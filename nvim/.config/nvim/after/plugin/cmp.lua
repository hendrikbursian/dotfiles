local cmp = require("cmp")
local luasnip = require("luasnip")

local options = {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(function()
            if (cmp.visible()) then
                cmp.select_next_item()
            else
                cmp.complete();
            end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },

        ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.select_next_item()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
        ['<C-p>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.select_prev_item()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end
        }),
    }),

    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,

        -- Let's play with this for a day or two
        ghost_text = false,
    },
}

-- Sorting
local compare = require('cmp.config.compare')
options.sorting = {
    priority_weight = 2,
    comparators = {
        compare.offset,
        compare.exact,
        compare.score,
        compare.recently_used,
        compare.kind,
        compare.sort_text,
        compare.length,
        compare.order,
    },
}

local hastabnine, tabnine = pcall(require, "cmp_tabnine.config")
if hastabnine then
        print("Using tabnine")
    tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
    })

    local tabnine_compare = require('cmp_tabnine.compare')
    table.insert(options.sorting.comparators, 0, tabnine_compare)
end

local cmp_kinds = {
    --      vscode
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
    --     default
    --     Text = "",
    --     Method = "",
    --     Function = "",
    --     Constructor = "",
    --     Field = "ﰠ",
    --     Variable = "",
    --     Class = "ﴯ",
    --     Interface = "",
    --     Module = "",
    --     Property = "ﰠ",
    --     Unit = "塞",
    --     Value = "",
    --     Enum = "",
    --     Keyword = "",
    --     Snippet = "",
    --     Color = "",
    --     File = "",
    --     Reference = "",
    --     Folder = "",
    --     EnumMember = "",
    --     Constant = "",
    --     Struct = "פּ",
    --     Event = "",
    --     Operator = "",
    --     TypeParameter = ""
}

options.formatting = {
    format = function(entry, vim_item)
        -- Icons
        vim_item.kind = string.format('%s %s', cmp_kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

        -- Source
        vim_item.menu = ({
            copilot = "[Copilot]",
            cmp_tabnine = "[Tabnine]",
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[Latex]",
        })[entry.source.name]

        return vim_item
    end
}

-- Sources
options.sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'buffer' },
    { name = 'copilot' },
}

if hastabnine then
    table.insert(options.sources, 1, { name = "cmp_tabnine" })
end

cmp.setup(options)

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    completion = { autocomplete = true },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
    })
})

local snippets_paths = function()
    local plugins = { "friendly-snippets" }
    local paths = {}
    local path
    local root_path = vim.env.XDG_DATA_HOME .. "/nvim/plugged/"
    for _, plug in ipairs(plugins) do
        path = root_path .. plug
        if vim.fn.isdirectory(path) ~= 0 then
            table.insert(paths, path)
        end
    end return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})
