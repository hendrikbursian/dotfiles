local lsp_installer = require("nvim-lsp-installer")
local file_exists = require("hendrik.utils").file_exists
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
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
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    if server.name == "intelephense" then
        local licence_path = vim.env.HOME .. "/intelephense/licence.txt"

        if(not file_exists(licence_path)) then
            print("Intelephense License missing!")
        end

        opts.settings = {
            intelephense = {
                stubs = {
                    "bcmath", "bz2", "calendar", "Core", "curl", "date", "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "recode", "Reflection", "regex", "session", "SimpleXML", "soap", "sockets", "sodium", "SPL", "standard", "superglobals", "sysvsem", "sysvshm", "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib", "wordpress", "woocommerce", "acf-pro", "wordpress-globals", "wp-cli", "genesis", "polylang"
                },
                files = {
                    maxSize = 5000000;
                },
            }
        }
    elseif server.name == "sumneko_lua" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    end

    server:setup(opts)
end)

