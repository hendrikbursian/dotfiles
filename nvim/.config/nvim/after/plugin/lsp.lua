require("nvim-lsp-installer").setup({
    automatic_installation = true,
})

local Remap = require("hendrik.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local lspconfig = require("lspconfig")


local illuminate_on_attach = require("illuminate").on_attach

local function on_attach(client, bufnr)
    -- Thanks!! Source: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua#L106
    -- local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    nnoremap("gd", vim.lsp.buf.definition, { buffer = bufnr })
    nnoremap("K", vim.lsp.buf.hover, { buffer = bufnr })
    nnoremap("<leader>vd", vim.diagnostic.open_float, { buffer = bufnr })
    nnoremap("[d", vim.diagnostic.goto_next, { buffer = bufnr })
    nnoremap("]d", vim.diagnostic.goto_prev, { buffer = bufnr })
    nnoremap("<leader>vca", vim.lsp.buf.code_action, { buffer = bufnr })
    nnoremap("<leader>.", vim.lsp.buf.code_action, { buffer = bufnr })
    vnoremap("<leader>rr", require("refactoring").select_refactor, { buffer = bufnr })
    nnoremap("<leader>vrn", vim.lsp.buf.rename, { buffer = bufnr })
    nnoremap("<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr })
    nnoremap("<leader>ct", vim.lsp.buf.incoming_calls, { buffer = bufnr })

    vnoremap("<leader>.", function() vim.lsp.buf.range_code_action({}) end, { buffer = bufnr })

    nnoremap("<leader>vf", function() return vim.lsp.buf.format({ async = true }) end, { buffer = bufnr })
    vnoremap("<leader>vf", function() return vim.lsp.buf.range_formatting({ async = true }) end, { buffer = bufnr })

    -- Telescope
    nnoremap("<leader>vrr", function() require("telescope.builtin").lsp_references() end, { buffer = bufnr })
    nnoremap("<leader>vws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        { buffer = bufnr })

    -- Illuminate
    -- Check these
    nnoremap("<a-n>", function() require('illuminate').next_reference({ wrap = true }) end, { buffer = bufnr })
    nnoremap("<a-p>", function() require('illuminate').next_reference({ reverse = true, wrap = true }) end,
        { buffer = bufnr })

    illuminate_on_attach(client)
end

local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)
    local global_ts = '/home/hendrik/.asdf/shims/tsserver'
    local found_ts = ''
    local function check_dir(path)
        found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
        if util.path.exists(found_ts) then
            return path
        end
    end

    if util.search_ancestors(root_dir, check_dir) then
        return found_ts
    else
        return global_ts
    end
end

local schemas = require('schemastore').json.schemas()

local servers = {
    ansiblels = {},
    awk_ls = {},
    cssls = {},
    cucumber_language_server = {},
    dotls = {},
    -- eslint = {},
    golangci_lint_ls = {},
    graphql = {},
    html = {},

    intelephense = {
        settings = {
            intelephense = {
                stubs = {
                    "bcmath", "bz2", "calendar", "Core", "curl", "date",
                    "dba", "dom", "enchant", "fileinfo", "filter", "ftp",
                    "gd", "gettext", "hash", "iconv", "imap", "intl",
                    "json", "ldap", "libxml", "mbstring", "mcrypt",
                    "mysql", "mysqli", "password", "pcntl", "pcre", "PDO",
                    "pdo_mysql", "Phar", "readline", "recode",
                    "Reflection", "regex", "session", "SimpleXML", "soap",
                    "sockets", "sodium", "SPL", "standard", "superglobals",
                    "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug",
                    "xmlreader", "xmlwriter", "yaml", "zip", "zlib",
                    "wordpress", "woocommerce", "acf-pro",
                    "wordpress-globals", "wp-cli", "genesis", "polylang"
                },
                files = {
                    maxSize = 5000000;
                },
            }
        }
    },

    jsonls = {
        settings = {
            json = {
                schemas = schemas,
                validate = { enable = true },
            },
        },
    },
    jsonnet_ls = {},
    lemminx = {},
    prismals = {},
    quick_lint_js = {},

    -- rome = {
    --     settings = {
    --         analysis = {
    --             enableCodeActions = true,
    --             enableDiagnostics = true,
    --         },
    --         formatter = {
    --             formatWithSyntaxErrors = true,
    --             indentStyle            = "Spaces",
    --             lineWidth              = 120,
    --             quoteStyle             = "Single",
    --             spaceQuantity          = 2,
    --         },
    --         lspBin = null,
    --         unstable = false,
    --     }
    -- },

    sqlls = {},

    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },

    -- tailwindcss = {},
    vimls = {},
    volar = {},
    yamlls = {},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local options = {
    on_attach = on_attach,
    capabilities = capabilities,
}

for server_name, server_options in pairs(servers) do
    --print('Configuring server: ' .. server_name)


    if server_name == 'intelephense' then
        local intelephense_licence_path = vim.fn.glob(vim.env.HOME .. "/intelephense/licence.txt")

        if (intelephense_licence_path == "") then
            print("Intelephense License missing!")
        end
    end

    options = vim.tbl_deep_extend("force", options, server_options)

    lspconfig[server_name].setup(options)
end

local tsserver_options = vim.tbl_deep_extend("force", options, {
    settings = {
        javascript = {
            suggest = {
                enable = false,
                completeFunctionCalls = false,
            },
        },
        typescript = {
            enablePromptUseWorkspaceTsdk = true,
            format = {
                enable = false,
            },
            suggest = {
                enable = true,
                completeFunctionCalls = true,
            },
        }
    }
})

require("typescript").setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    server = tsserver_options,
})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.completion.spell,

        -- ESlint
        require("null-ls").builtins.diagnostics.eslint_d,
        require("null-ls").builtins.code_actions.eslint_d,
        --require("null-ls").builtins.formatting.eslint_d,

        require("null-ls").builtins.formatting.prettier_d_slim,
    },
})
