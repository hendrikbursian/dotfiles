local ok, _ = pcall(require, "lspconfig")
if not ok then
    return
end

local function on_attach(client, bufnr)
    -- Thanks!!
    -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua
    -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

    local ok_illuminate, illuminate = pcall(require, "illuminate")
    local ok_dap, dap = pcall(require, "dap")

    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    -- Create buffer mappings on active dap session. Reverts mappings afterwards.
    local function nmap_dap(keys, func, desc)
        if not ok_dap then
            return
        end

        local keymaps = vim.api.nvim_buf_get_keymap(bufnr, "n")
        local event_key = "n_" .. keys

        -- TODO: Theres probably a better way to do this
        local default_keymap
        for _, keymap in pairs(keymaps) do
            if keymap.lhs == keys then
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

        local opts = {
            buffer = bufnr,
            desc = desc,
        }

        dap.listeners.after["event_initialized"][event_key] = function()
            vim.keymap.set("n", keys, func, opts)
        end

        dap.listeners.after["event_terminated"][event_key] = function()
            if default_keymap == nil then
                vim.keymap.del("n", keys, opts)
            else
                vim.keymap.set("n", default_keymap.lhs, default_keymap.rhs, default_keymap.opts)
            end
        end
    end

    nmap("<leader>vrn", vim.lsp.buf.rename, "[V]im [R]e[n]ame")
    nmap("<leader>.", vim.lsp.buf.code_action, "Code Action (Habit from VSCode <C-.>)")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-K>", vim.lsp.buf.signature_help, "Signature Help")

    nmap("<leader>ct", vim.lsp.buf.incoming_calls, "Incoming [C]alls")

    nmap("<leader>vf", vim.lsp.buf.format, "[V]im [F]ormat")

    -- Telescope
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("gr", require("hendrik.telescope").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- Lesser used LSP functionality
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end,
        "[W]orkspace [L]ist Folders")

    -- Dap
    nmap_dap("K", function() require("dap.ui.widgets").hover() end, "Debug Hover")

    if ok_illuminate then
        illuminate.on_attach(client)
    end
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
    },

    jsonls = {
        json = {
            schemas = json_schemas,
            validate = { enable = true },
        },
    },

    jsonnet_ls = {},
    lemminx = {},
    prismals = {},

    -- rome = {
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
    -- },

    sqlls = {},

    sumneko_lua = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false, },
        },
    },

    vimls = {},
    volar = {},
    yamlls = {
        yaml = {
            schemas = yaml_schemas,
            customTags = { "!reference sequence" }
        }
    },
}

-- Schemas (json,yaml) =======================================================
local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then
    neodev.setup({})
end

-- Schemas (json,yaml) =======================================================
local ok_schemastore, schemastore = pcall(require, "schemastore")
local json_schemas = {}
if ok_schemastore then
    json_schemas = schemastore.json.schemas()
end

-- https://github.com/redhat-developer/yaml-language-server#associating-a-schema-to-a-glob-pattern-via-yamlschemas
local yaml_schemas = {
    -- -- Gitlab CI
    -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
    --     "**/.gitlab/**/*.yml",
    --     "**/.gitlab/**/*.yaml"
    -- },
    -- Docker Compose
    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
        "docker-compose.*.yml.template",
        "docker-compose.*.yaml.template"
    },
}


local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Mason =====================================================================
require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = vim.tbl_keys(servers),
})
require("mason-lspconfig").setup_handlers({
    function(server_name)
        if server_name == "intelephense" then
            local intelephense_licence_path = vim.fn.glob(vim.env.HOME .. "/intelephense/licence.txt")

            if (intelephense_licence_path == "") then
                print("Intelephense License missing!")
            end
        end

        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

-- Mason DAP =================================================================
require("mason-nvim-dap").setup({
    automatic_installation = true,
    ensure_installed = { "codelldb" },
    automatic_setup = true,
})
require("mason-nvim-dap").setup_handlers({
    function(source_name)
        -- all sources with no handler get passed here
        -- Keep original functionality of `automatic_setup = true`
        require("mason-nvim-dap.automatic_setup")(source_name)
    end,
})

-- Extended Tooling ==========================================================
-- Typescript
local ok_typescript, typescript = pcall(require, "typescript")
if ok_typescript then
    typescript.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        server = {
            capabilities = capabilities,
            on_attach = on_attach,

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
        },
    })
end

-- Rust
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

                vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                vim.keymap.set("n", "<leader>rr", function() vim.cmd("RustRun") end, { buffer = bufnr })
            end,
        },
    })

    rust_tools.inlay_hints.enable()
end

-- Eslint Actions (Complements linting from nvim-lint on_save)
local ok_null_ls, null_ls = pcall(require, "null-ls")
if ok_null_ls then
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint_d,
        },
    })
end
