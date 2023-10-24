-- PHP LSP
return {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
        local utils = require("hendrik.utils")

        local license_path = vim.env.HOME .. "/intelephense/licence.txt"
        local license_exists = utils.path.exists(license_path)

        if not license_exists then
            vim.defer_fn(
                function() vim.notify("Intelephense License missing!", vim.log.levels.WARN) end,
                0)
        end

        return vim.tbl_deep_extend("force", opts, {
            servers = {
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
                }
            },
        })
    end
}
