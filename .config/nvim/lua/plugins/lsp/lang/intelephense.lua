-- PHP LSP
-- TODO: The settings are not applied in the lsp configs!!!!!
return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local utils = require("hendrik.utils")

		local license_path = vim.env.HOME .. "/intelephense/licence.txt"
		local license_exists = utils.path.exists(license_path)

		if not license_exists then
			vim.defer_fn(function()
				vim.notify("Intelephense License missing!", vim.log.levels.WARN)
			end, 0)
		end

		local settings = {
            -- stylua: ignore
			stubs = { "Core", "PDO", "Phar", "Reflection", "SPL", "SimpleXML", "acf-pro", "bcmath", "bz2", "calendar", "curl", "date", "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "genesis", "gettext", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "pdo_mysql", "polylang", "readline", "recode", "regex", "session", "soap", "sockets", "sodium", "standard", "superglobals", "sysvsem", "sysvshm", "tokenizer", "woocommerce", "wordpress-stubs", "Wordpress", "wordpress-globals", "wp-cli", "xdebug", "xml", "xmlreader", "xmlwriter", "yaml", "zip", "zlib", },
			diagnostics = {
				undefined_functions = false,
				undefinedFunctions = false,
			},
			environment = {
				includePaths = {
					os.getenv("COMPOSER_HOME") .. "/vendor/php-stubs",
				},
			},
			files = {
				maxSize = 32 * 1024 * 1024, -- MB
			},
		}

		return vim.tbl_deep_extend("force", opts, {
			servers = {
				intelephense = settings,
			},
		})
	end,
}
