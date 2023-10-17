local ok, cmp = pcall(require, "cmp")
if not ok or cmp == nil then
    return
end

local ok, cmp_npm = pcall(require, "cmp-npm")
if ok then
    cmp_npm.setup({})
end

local ok_luasnip, luasnip = pcall(require, "luasnip")

local options = {
    snippet = {
        expand = function(args)
            if ok_luasnip then
                luasnip.lsp_expand(args.body)
            else
                print("Error loading Luasnip")
            end
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),

        ["<C-Space>"] = cmp.mapping(function(fallback)
            if (cmp.visible()) then
                cmp.select_next_item()
            else
                cmp.complete()
            end
        end, { "i", "s" }),

        -- Enter: Insert
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),

        -- TAB: Replace
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                })
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    experimental = {
        ghost_text = true,
    },
}

-- Sorting
local compare = require("cmp.config.compare")
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

local ok_tabnine, tabnine = pcall(require, "cmp_tabnine.config")
if ok_tabnine then
    print("Using tabnine")
    tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
    })

    local tabnine_compare = require("cmp_tabnine.compare")
    table.insert(options.sorting.comparators, 0, tabnine_compare)
end

local cmp_kinds = {
    --      vscode
    Text = "  ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
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
        vim_item.kind = string.format("%s %s", cmp_kinds[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind

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
    { name = "path" },
    { name = "npm",     keyword_length = 4 },
    { name = "calc" },
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer",  keyword_length = 2, max_item_count = 7 },
}

if ok_tabnine then
    table.insert(options.sources, 6, { name = "cmp_tabnine" })
end

cmp.setup(options)
cmp.setup(options)

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer", keyword_length = 4 },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    })
})


-- Autocomplete brackets for method
local ok_autopairs, autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if ok_autopairs then
    cmp.event:on("confirm_done", autopairs.on_confirm_done())
end

-- Snippets
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
    end
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})
