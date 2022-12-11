local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
    return
end

local Remap = require("hendrik.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local ok_illuminate, illuminate = pcall(require, "illuminate")
local ok_dap, dap = pcall(require, "dap")

local function nnoremap_dap(lhs, rhs, opts)
    if not ok_dap then
        return
    end

    local keymaps = vim.api.nvim_buf_get_keymap(opts.buffer, "n")
    local event_key = "n_" .. lhs

    local default_keymap
    for _, keymap in pairs(keymaps) do
        if keymap.lhs == lhs then
            default_keymap = {
                lhs = keymap.lhs,
                rhs = keymap.callback,
                opts = {
                    silent = keymap.silent,
                    buffer = keymap.buffer,
                    nowait = keymap.nowait,
                    script = keymap.script,
                }
            }
        end
    end

    dap.listeners.after["event_initialized"][event_key] = function()
        nnoremap(lhs, rhs, opts)
    end

    dap.listeners.after["event_terminated"][event_key] = function()
        if default_keymap == nil then
            vim.keymap.del("n", lhs, opts)
        else
            nnoremap(default_keymap.lhs, default_keymap.rhs, default_keymap.opts)
        end
    end
end

local function on_attach(client, bufnr)
    -- Thanks!! Source: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua#L106
    -- local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

    nnoremap("gd", vim.lsp.buf.definition, { buffer = bufnr })
    nnoremap("gi", vim.lsp.buf.implementation, { buffer = bufnr })

    nnoremap("K", vim.lsp.buf.hover, { buffer = bufnr })
    nnoremap("<leader>vd", vim.diagnostic.open_float, { buffer = bufnr })
    nnoremap("[d", vim.diagnostic.goto_next, { buffer = bufnr })
    nnoremap("]d", vim.diagnostic.goto_prev, { buffer = bufnr })
    nnoremap("<leader>vrn", vim.lsp.buf.rename, { buffer = bufnr })
    nnoremap("<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr })
    nnoremap("<leader>ct", vim.lsp.buf.incoming_calls, { buffer = bufnr })

    nnoremap("<leader>.", vim.lsp.buf.code_action, { buffer = bufnr })
    vnoremap("<leader>.", function() vim.lsp.buf.range_code_action({}) end, { buffer = bufnr })

    nnoremap("<leader>vf", function() return vim.lsp.buf.format({ async = true }) end, { buffer = bufnr })
    vnoremap("<leader>vf", function() return vim.lsp.buf.range_formatting({ async = true }) end, { buffer = bufnr })

    -- Telescope
    nnoremap("<leader>vrr", function() require("telescope.builtin").lsp_references({ fname_width = 60 }) end,
        { buffer = bufnr })
    nnoremap("<leader>vws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
        { buffer = bufnr })

    -- Dap
    nnoremap_dap("K", function() require("dap.ui.widgets").hover() end, { silent = true, buffer = bufnr })

    if ok_illuminate then
        illuminate.on_attach(client)
    end
end

local ok_schemastore, schemastore = pcall(require, "schemastore")
local schemas = {}
if ok_schemastore then
    schemas = schemastore.json.schemas()
end

local servers = {
    ansiblels = {},
    awk_ls = {},
    cssls = {},
    cucumber_language_server = {},
    dockerls = {},
    gopls = {},
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
                    globals = { "vim" },
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

    vimls = {},
    volar = {},
    yamlls = {},
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local options = {
    on_attach = on_attach,
    capabilities = capabilities,
}

for server_name, server_options in pairs(servers) do
    --print("Configuring server: " .. server_name)

    if server_name == "intelephense" then
        local intelephense_licence_path = vim.fn.glob(vim.env.HOME .. "/intelephense/licence.txt")

        if (intelephense_licence_path == "") then
            print("Intelephense License missing!")
        end
    end

    options = vim.tbl_deep_extend("force", options, server_options)

    lspconfig[server_name].setup(options)
end

local ok_typescript, typescript = pcall(require, "typescript")
if ok_typescript then
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

    typescript.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        server = tsserver_options,
    })
end

local ok_rust_tools, rust_tools = pcall(require, "rust-tools")
if ok_rust_tools then
    rust_tools.setup({
        tools = {
            hover_actions = {},
        },

        dap = {
            adapter = require("mason-nvim-dap.mappings.adapters").codelldb,
        },

        server = {
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)

                nnoremap("K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
            end,
        },
    })

    rust_tools.inlay_hints.enable()
end

local ok_null_ls, null_ls = pcall(require, "null-ls")
if ok_null_ls then
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint_d,
        },
    })
end
