local fn = vim.fn
local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local options = {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },

    mapping = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(function()
            if(cmp.visible()) then
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

        ["<S-Tab>"] = cmp.mapping(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
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

local hastabnine,tabnine = pcall(require,"cmp_tabnine.config")
if hastabnine then
    tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
    })
end

if hastabnine then
    table.insert(options.sorting.comparators, 0, tabnine.compare)
end

-- Formatting
local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

local cmp_kinds = {
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
}

-- minimal
-- options.formatting = {
--     format = function(entry, vim_item)
--         vim_item.kind = require("lspkind").presets.default[vim_item.kind]
--         local menu = source_mapping[entry.source.name]
--         if entry.source.name == "cmp_tabnine" then
--             if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
--                 menu = entry.completion_item.data.detail .. " " .. menu
--             end
--             vim_item.kind = ""
--         end
--         vim_item.menu = menu
--         return vim_item
--     end
-- }

-- standard
options.formatting = {
    format = function(_, vim_item)
        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
        return vim_item
    end,
}

-- vscode
-- options.formatting = {
--     fields = { "kind", "abbr" },
--     format = function(entry, vim_item)
--         local menu = source_mapping[entry.source.name]
--
--         if entry.source.name == "cmp_tabnine" then
--             if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
--                 menu = entry.completion_item.data.detail .. " " .. menu
--             end
--             vim_item.kind = ""
--         else
--             vim_item.kind = cmp_kinds[vim_item.kind] or ""
--         end
--
--         vim_item.menu = menu
--
--         return vim_item
--     end,
-- }

-- Sources
options.sources = {
    { name = "path" },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'buffer' },
}

if hastabnine then
    table.insert(options.sources, 1, { name = "cmp_tabnine" })
end

cmp.setup(options)

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
})

cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
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
    end
    return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
    paths = snippets_paths(),
    include = nil, -- Load all languages
    exclude = {},
})


