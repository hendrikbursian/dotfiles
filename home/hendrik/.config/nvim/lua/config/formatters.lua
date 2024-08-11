local M = {}
M.formatters_by_ft = {
	lua = { "stylua" },
	javascript = { "eslint_d", "eslint", "prettierd", "prettier" },
	typescript = { "eslint_d", "eslint", "prettierd", "prettier" },
	css = { "eslint_d", "prettierd", "prettier" },
	html = { "eslint_d", "prettierd", "prettier" },
	vue = { "eslint_d", "prettierd", "prettier" },
	go = { "gofmt" },
	rust = { "rustfmt" },
	sh = { "shellcheck", "shfmt" },
	bash = { "shfmt" },
	sql = { "sql_formatter" },
	yaml = { "prettierd", "prettier" },
	json = { "prettier" },
	php = { "phpcbf" },
	templ = { "templ" },
	nix = { "nixpkgs_fmt" },
	blade = { "blade-formatter" },

	-- filetypes without defined formatters
	["_"] = { "trim_newlines", "trim_whitespace" },

	-- every filetype (including the above ones)
	["*"] = { "trim_newlines", "trim_whitespace" },
}
return M
