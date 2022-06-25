require("nvim-lsp-installer").setup({
    automatic_installation = true,
})

local lspconfig = require("lspconfig")

local file_exists = require("hendrik.utils").file_exists
local illuminate_on_attach = require("illuminate").on_attach

local function on_attach(client, bufnr)
    Nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    Nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    Nnoremap("<leader>vws", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>")
    Nnoremap("<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>")
    Nnoremap("[d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
    Nnoremap("]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    Nnoremap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    Nnoremap("<leader>.", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    --  Nnoremap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
    Nnoremap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    Nnoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    -- N- TODO: use Range where applicable
    -- N- vim.lsp.buf.range_formatting()
    -- Nnoremap("<leader>vf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>")

    -- Nnoremap("<leader>ct", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
    Nnoremap("<leader>ct", "<cmd>IncomingCalls<CR>")

    Nnoremap("<leader>vf", "<cmd>Neoformat<CR>")

    -- Illuminate
    -- Check these
    Nnoremap('<A-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
    Nnoremap('<A-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')

    illuminate_on_attach(client)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
    ansiblels = {},
    awk_ls = {},
    cssls = {},
    cucumber_language_server = {},
    dotls = {},
    eslint = {},
    golangci_lint_ls = {},
    graphql = {},
    html = {},
    jsonls = {},
    jsonnet_ls = {},
    prismals = {},
    quick_lint_js = {},
    sqlls = {},
    sumneko_lua = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'},
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
    volar = {},
    yamlls = {},

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

    tsserver = {
        settings = {
            javascript = {
                suggest = {
                    enable = true,
                    completeFunctionCalls = true,
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
    },

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

    diagnosticls = {
        filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
        init_options = {
            filetypes = {
                javascript = "eslint",
                typescript = "eslint",
                javascriptreact = "eslint",
                typescriptreact = "eslint"
            },
            linters = {
                eslint = {
                    sourceName = "eslint",
                    command = "eslint_d",
                    rootPatterns = {
                        ".eslitrc.js",
                        "package.json"
                    },
                    debounce = 100,
                    args = {
                        "--cache",
                        "--stdin",
                        "--stdin-filename",
                        "%filepath",
                        "--format",
                        "json"
                    },
                    parseJson = {
                        errorsRoot = "[0].messages",
                        line = "line",
                        column = "column",
                        endLine = "endLine",
                        endColumn = "endColumn",
                        message = "${message} [${ruleId}]",
                        security = "severity"
                    },
                    securities = {
                        [2] = "error",
                        [1] = "warning"
                    }
                }
            }
        }
    }
}


for server_name, server_options in pairs(servers) do
    print('Configuring server: ' .. server_name)

    local options = {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    if server_name == 'intelephense' then
        local intelephense_licence_path = vim.env.HOME .. "/intelephense/licence.txt"
        if (not file_exists(intelephense_licence_path)) then
            print("Intelephense License missing!")
        end
    end


    for k, v in pairs(server_options) do
        options[k] = v
    end

    lspconfig[server_name].setup(options)
end

