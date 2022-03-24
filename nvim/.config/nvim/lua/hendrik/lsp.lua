local cmp_nvim_lsp = require('cmp_nvim_lsp')
local cmp = require('cmp')
local compare = require('cmp.config.compare')
local hastabnine,tabnine = pcall(require,"cmp_tabnine.config")
local lspconfig_configs = require('lspconfig.configs')
local lspconfig_util = require('lspconfig.util')

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

local lspkind = require("lspkind")

local formatting = {

    minimal = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        local menu = source_mapping[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
            if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                menu = entry.completion_item.data.detail .. " " .. menu
            end
            vim_item.kind = ""
        end
        vim_item.menu = menu
        return vim_item
    end,

    standard = {
        format = function(_, vim_item)
            vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
            return vim_item
        end,
    },

    vscode = {
        fields = { "kind", "abbr" },
        format = function(entry, vim_item)
            local menu = source_mapping[entry.source.name]

            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            else
                vim_item.kind = cmp_kinds[vim_item.kind] or ""
            end

            vim_item.menu = menu

            return vim_item
        end,
    },
}

local sorting = {
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

if hastabnine then
    table.insert(sorting.comparators, 0, tabnine.compare)
end

local function next_or_complete(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        cmp.mapping.complete()
    end
end

cmp.setup({

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
        ['<C-Space>'] = cmp.mapping(next_or_complete, { "i", "s" }),

--        ["<Tab>"] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_next_item()
--            elseif luasnip.expand_or_jumpable() then
--                luasnip.expand_or_jump()
--            elseif has_words_before() then
--                cmp.complete()
--            else
--                fallback()
--            end
--        end, { "i", "s" }),
--
--        ["<S-Tab>"] = cmp.mapping(function(fallback)
--            if cmp.visible() then
--                cmp.select_prev_item()
--            elseif luasnip.jumpable(-1) then
--                luasnip.jump(-1)
--            else
--                fallback()
--            end
--        end, { "i", "s" }),
    },

    sorting = sorting,

	formatting = formatting.vscode,

    sources = {
        { name = "path" },

        { name = "cmp_tabnine" },

        { name = 'nvim_lsp' },

        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.

        { name = 'calc' },

        { name = 'buffer' },
    },
})

cmp.setup.cmdline('/', {
    sources = { { name = 'buffer' }, },
    mapping = {
        ['<C-Space>'] = cmp.mapping(next_or_complete, { "i", "s" }),
    }
})

-- TODO: !<expansion> not working
-- cmp.setup.cmdline(':', {
--     sources = {
--         { name = 'path', keyword_pattern=[=[[^[:blank:]\!]*]=] },
--         { name = 'cmdline', keyword_pattern=[=[[^[:blank:]\!]*]=] },
--     },

--     mapping = {
--         ['<C-Space>'] = cmp.mapping(next_or_complete, { "i", "s" }),
--     }
-- })

-- Setup lspconfig.
if hastabnine then
    tabnine:setup({
    	max_lines = 1000,
    	max_num_results = 20,
    	sort = true,
    	run_on_every_keystroke = true,
    	snippet_placeholder = "..",
    })
end

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
			Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
			Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
			Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
			Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
			Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
			Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
			Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
			Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
			Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		end,
	}, _config or {})
end

local function on_new_config(new_config, new_root_dir)
    local function get_typescript_server_path(root_dir)
        local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
        return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
        or ''
    end

    if
        new_config.init_options
        and new_config.init_options.typescript
        and new_config.init_options.typescript.serverPath == '' then
        new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
    end
end

-- TODO: Check vue language server
local volar_cmd = {'vue-language-server', '--stdio'}
local volar_root_dir = lspconfig_util.root_pattern('package.json')

lspconfig_configs.volar_api = {
    default_config = {
        cmd = volar_cmd,
        root_dir = volar_root_dir,
        on_new_config = on_new_config,
        -- filetypes = { 'vue'},
        -- If you want to use Volar's Take Over Mode (if you know, you know)
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        init_options = {
            typescript = {
                serverPath = ''
            },
            languageFeatures = {
                implementation = true, -- new in @volar/vue-language-server v0.33
                references = true,
                definition = true,
                typeDefinition = true,
                callHierarchy = true,
                hover = true,
                rename = true,
                renameFileRefactoring = true,
                signatureHelp = true,
                codeAction = true,
                workspaceSymbol = true,
                completion = {
                    defaultTagNameCase = 'both',
                    defaultAttrNameCase = 'kebabCase',
                    getDocumentNameCasesRequest = false,
                    getDocumentSelectionRequest = false,
                },
            }
        },
    }
}
require("lspconfig").volar_api.setup(config())

lspconfig_configs.volar_doc = {
    default_config = {
        cmd = volar_cmd,
        root_dir = volar_root_dir,
        on_new_config = on_new_config,

        --filetypes = { 'vue' },
        -- If you want to use Volar's Take Over Mode (if you know, you know):
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
        init_options = {
            typescript = {
                serverPath = ''
            },
            languageFeatures = {
                implementation = true, -- new in @volar/vue-language-server v0.33
                documentHighlight = true,
                documentLink = true,
                codeLens = { showReferencesNotification = true},
                -- not supported - https://github.com/neovim/neovim/pull/15723
                semanticTokens = false,
                diagnostics = true,
                schemaRequestService = true,
            }
        },
    }
}
require("lspconfig").volar_doc.setup(config())

lspconfig_configs.volar_html = {
    default_config = {
        cmd = volar_cmd,
        root_dir = volar_root_dir,
        on_new_config = on_new_config,

        --filetypes = { 'vue'},
        -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        init_options = {
            typescript = {
                serverPath = ''
            },
            documentFeatures = {
                selectionRange = true,
                foldingRange = true,
                linkedEditingRange = true,
                documentSymbol = true,
                documentColor = true,
                documentFormatting = {
                    defaultPrintWidth = 100,
                },
            }
        },
    }
}
require("lspconfig").volar_html.setup(config())

require("lspconfig").eslint.setup(config())

require("lspconfig").spectral.setup(config())

require("lspconfig").ccls.setup(config())


local function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

local licence_path = vim.env.HOME .. "/intelephense/licence.txt"
if(not file_exists(licence_path)) then
    print("Intelephense License missing!")
end

require('lspconfig').intelephense.setup(config({
    settings = {
        intelephense = {
            stubs = {
                "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "recode", "Reflection", "regex", "session", "SimpleXML", "soap", "sockets", "sodium", "SPL", "standard", "superglobals", "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib", "wordpress", "woocommerce", "acf-pro", "wordpress-globals", "wp-cli", "genesis", "polylang"
            },
            files = {
                maxSize = 5000000;
            },
        }
    }
}))

-- TODO: Check this!
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
