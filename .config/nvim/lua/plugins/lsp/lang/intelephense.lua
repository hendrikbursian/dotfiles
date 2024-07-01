-- PHP LSP
return {
	"neovim/nvim-lspconfig",
	opts = function(_, opts)
		local utils = require("modules.utils")

		local license_path = vim.env.HOME .. "/intelephense/licence.txt"
		local license_exists = utils.path.exists(license_path)

		if not license_exists then
			vim.defer_fn(function()
				vim.notify("Intelephense License missing!", vim.log.levels.WARN)
			end, 0)
		end

		local settings = {
			intelephense = {
                -- stylua: ignore
                stubs = { "Core", "PDO", "Phar", "Reflection", "SPL", "SimpleXML", "acf-pro", "bcmath", "bz2", "calendar", "curl", "date", "dba", "dom", "enchant", "fileinfo", "filter", "ftp", "gd", "genesis", "gettext", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "pdo_mysql", "polylang", "readline", "recode", "regex", "session", "soap", "sockets", "sodium", "standard", "superglobals", "sysvsem", "sysvshm", "tokenizer", "woocommerce", "Wordpress", "wp-cli", "xdebug", "xml", "xmlreader", "xmlwriter", "yaml", "zip", "zlib" },
				environment = {
					includePaths = {
						-- os.getenv("COMPOSER_HOME") .. "/vendor/php-stubs",
					},
				},
				files = {
					maxSize = 32 * 1024 * 1024, -- MB
				},
			},
		}

		-- TODO: use this in on_new_config (lspconfig.intelephense.on_new_config)
		local cwd = utils.get_git_dir_or_cwd()
		local wp_home = utils.find_wp_ancestor(cwd)
		if wp_home ~= nil then
			table.insert(settings.intelephense.environment.includePaths, wp_home)
		end

		return vim.tbl_deep_extend("force", opts, {
			servers = {
				intelephense = settings,
			},
		})
	end,
}
