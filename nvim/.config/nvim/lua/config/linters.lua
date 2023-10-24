local M = {}
M.linters_by_ft = {
	typescript = { "eslint_d" },
	vue = { "eslint_d" },
	javascript = { "eslint_d" },
	css = { "eslint_d" },
	dockerfile = { "hadolint" },
	sh = { "shellcheck" },

	-- {"ansible_lint"}
	-- {"codespell"}
	-- {"dotenv_linter"}
	-- {"editorconfig-checker"}
	-- {"write_good"}
	-- {"yarmllint"}
	-- {"trivy"}
}
return M
