local M = {}
M.formatters_by_ft = {
	lua = { "stylua" },
	javascript = { { "eslint_d", "prettierd", "prettier" } },
	typescript = { { "eslint_d", "prettierd", "prettier" } },
	css = { { "eslint_d", "prettierd", "prettier" } },
	html = { { "eslint_d", "prettierd", "prettier" } },
	vue = { { "eslint_d", "prettierd", "prettier" } },
	go = { { "gofmt" } },
	rust = { { "rustfmt" } },
	sh = { { "shellcheck", "shfmt" } },
	bash = { { "shfmt" } },
	sql = { { "sql_formatter" } },
	yaml = { { "prettierd", "prettier" } },
	json = { { "prettierd", "prettier" } },
	php = { { "phpcbf" } },
	templ = { { "templ" } },
	nix = { { "nixpkgs-fmt" } },

	-- filetypes without defined formatters
	["_"] = { "trim_newlines", "trim_whitespaces" },

	-- every filetype (including the above ones)
	-- ["*"] = {},
}
return M
