-- Schemas (json, yaml)
-- Autocompletion for jsonls/yamls
return {
	"neovim/nvim-lspconfig",
	dependencies = { "b0o/schemastore.nvim" },
	opts = function(_, opts)
		local schemastore = require("schemastore")

		local schemas = schemastore.yaml.schemas()

		-- https://github.com/redhat-developer/yaml-language-server#associating-a-schema-to-a-glob-pattern-via-yamlschemas
		local custom_schemas = {
			-- Gitlab CI
			["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
				"**/.gitlab/**/*.yml",
				"**/.gitlab/**/*.yaml",
			},
			-- Docker Compose
			["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
				"docker-compose.*.yml.template",
				"docker-compose.*.yaml.template",
			},
		}

		for schema_url, filenames in pairs(custom_schemas) do
			for _, filename in ipairs(filenames) do
				table.insert(schemas[schema_url], filename)
			end
		end

		return vim.tbl_deep_extend("force", opts, {
			servers = {
				yamlls = {
					yaml = {
						schemas = schemas,
						customTags = { "!reference sequence" },
					},
				},
			},
		})
	end,
}
