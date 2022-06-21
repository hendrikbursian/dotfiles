require("nvim-lsp-installer").setup({})

local lspconfig = require("lspconfig")

local file_exists = require("hendrik.utils").file_exists
local illuminate_on_attach = require("illuminate").on_attach

local function on_attach(client, bufnr)
    Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
    Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
    Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
    Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
    Nnoremap("[d", ":lua vim.diagnostic.goto_next()<CR>")
    Nnoremap("]d", ":lua vim.diagnostic.goto_prev()<CR>")
    Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
    Nnoremap("<leader>.", ":lua vim.lsp.buf.code_action()<CR>")
    --  Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
    Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
    Nnoremap("<C-h>", ":lua vim.lsp.buf.signature_help()<CR>")
    -- N- TODO: use Range where applicable
    -- N- vim.lsp.buf.range_formatting()
    Nnoremap("<leader>vf", ":lua vim.lsp.buf.format({ async = true })<CR>")

    -- Nnoremap("<leader>ct", ":lua vim.lsp.buf.incoming_calls()<CR>")
    Nnoremap("<leader>ct", ":IncomingCalls<CR>")

    -- Illuminate
    Nnoremap('<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')
    Nnoremap('<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>')

    illuminate_on_attach(client)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
    'ansiblels',
    'awk_ls',
    'cssls',
    'cssmodules_ls',
    'cucumber_language_server',
    'dotls',
    'eslint',
    'golangci_lint_ls',
    'graphql',
    'html',
    'jedi_language_server',
    'jsonls',
    'jsonnet_ls',
    'lemminx',
    'marksman',
    'prismals',
    'prosemd_lsp',
    'quick_lint_js',
    'remark_ls',
    'rome',
    'sqlls',
    'sqls',
    'stylelint_lsp',
    'sumneko_lua',
    'tailwindcss',
    'taplo',
    'tsserver',
    'volar',
    'zk',
}

local server_options = {
    rome = {
        settings = {
            analysis = {
                enableCodeActions = true,
                enableDiagnostics = true,
            },
            formatter = {
                formatWithSyntaxErrors = true,
                indentStyle            = "Spaces",
                lineWidth              = 120,
                quoteStyle             = "Single",
                spaceQuantity          = 2,
            },
            lspBin = null,
            unstable = false,
        }
    },
    tsserver = {
        on_attach = function(client, bufnr)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false

            on_attach(client, bufnr)
        end,
        settings = {
            javascript = {
                format = {
                    enable = false,
                },
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
    }
}

function print_table(node)
    -- to make output beautiful
    local function tab(amt)
        local str = ""
        for i = 1, amt do
            str = str .. "\t"
        end
        return str
    end

    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. tab(depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. tab(depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. tab(depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output, output_str)
    output_str = table.concat(output)

    print(output_str)
end

for _, server_name in pairs(servers) do
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

    if server_name == 'tsserver' then
        --        print_table(options)
        options.on_new_config = function(new_config, new_root_dir)
            new_config.languageFeatures = {
                callHierarchy = true,
            }
        end
    end

    if server_options[server_name] then
        for k, v in pairs(server_options[server_name]) do
            options[k] = v
        end
    end

    lspconfig[server_name].setup(options)
end
