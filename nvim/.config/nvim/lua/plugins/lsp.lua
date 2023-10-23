local utils = require("hendrik.utils")


local function on_attach(_, bufnr)
    -- Thanks!!
    -- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua
    -- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>vrn", vim.lsp.buf.rename, "[V]im [R]e[n]ame")
    nmap("<leader>.", vim.lsp.buf.code_action, "Code Action (Habit from VSCode <C-.>)")

    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Help")

    nmap("<leader>ct", vim.lsp.buf.incoming_calls, "Incoming [C]alls")

    nmap("<leader>vf", vim.lsp.buf.format, "[V]im [F]ormat")

    -- Telescope
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    nmap("gr", require("hendrik.telescope").lsp_references, "[G]oto [R]eferences")
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    nmap("<leader>K", function() vim.lsp.inlay_hint(0, nil) end, "Toggle Inlay Hints")

    -- Lesser used LSP functionality
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function() vim.pretty_print(vim.lsp.buf.list_workspace_folders()) end,
        "[W]orkspace [L]ist Folders")
end

return {

    -- LSP
    {
        "neovim/nvim-lspconfig",
        event = utils.FileEvent,
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Additional lua configuration
            {
                "folke/neodev.nvim",
                config = true
            },

            -- Usage for Linting Actions
            {
                "jose-elias-alvarez/null-ls.nvim",
                opts = function()
                    local null_ls = require("null-ls")

                    return {
                        sources = {
                            null_ls.builtins.code_actions.eslint_d,
                        },
                    }
                end
            },

            -- Extended Typescript Tools
            "jose-elias-alvarez/typescript.nvim",

            -- Extended Rust Tools
            "simrat39/rust-tools.nvim",

            -- Autocompletion for jsonls/yamls
            "b0o/schemastore.nvim",

        },
        opts = function()
            -- Schemas (json,yaml) =======================================================
            local schemastore = require("schemastore")
            json_schemas = schemastore.json.schemas()

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

            local servers = {
                ansiblels = {},
                cssls = {},
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
                            maxSize = 5000000,
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

                sqlls = {},

                tailwindcss = {
                    tailwindCSS = {
                        experimental = {
                            -- classRegex = {
                            --     "ui:\\s*{([^)]*)\\s*}", "[\"'`]([^\"'`]*).*?[\"'`]",
                            --     "/\\*ui\\*/\\s*{([^;]*)}", ":\\s*[\"'`]([^\"'`]*).*?[\"'`]"
                            -- }
                        }
                    }
                },

                lua_ls = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false, },
                        hint = { enable = true, },
                    },
                },

                volar = {},
                yamlls = {
                    yaml = {
                        schemas = yaml_schemas,
                        customTags = { "!reference sequence" }
                    }
                },
            }

            return {
                servers = servers
            }
        end,
        config = function(_, opts)
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = vim.tbl_keys(opts.servers),
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    if server_name == "intelephense" then
                        local intelephense_licence_path = vim.fn.glob(vim.env.HOME .. "/intelephense/licence.txt")

                        -- if (intelephense_licence_path == "") then
                        --     print("Intelephense License missing!")
                        -- end
                    end

                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = opts.servers[server_name],
                    })
                end,


                ["rust_analyzer"] = function()
                    local ok_rust_tools, rust_tools = pcall(require, "rust-tools")
                    if ok_rust_tools then
                        rust_tools.setup({
                            server = {
                                on_attach = function(client, bufnr)
                                    on_attach(client, bufnr)

                                    vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
                                    vim.keymap.set("n", "<leader>s", function() vim.cmd("RustRun") end,
                                        { buffer = bufnr })
                                end,
                            },
                        })
                    end
                end,

                ["tsserver"] = function()
                    require("typescript").setup({
                        disable_commands = false, -- prevent the plugin from creating Vim commands
                        debug = false,            -- enable debug logging for commands
                        server = {
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = {
                                javascript = {
                                    suggest = {
                                        enable = false,
                                        completeFunctionCalls = false,
                                    },
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
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
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                }
                            }
                        },
                    })
                end
            })
        end
    },

    -- Automatically install LSPs
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                "prettierd",
                "stylua",
                "shfmt",
                "hadolint",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr:on("package:install:success", function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require("lazy.core.handler.event").trigger({
                        event = "FileType",
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
}
