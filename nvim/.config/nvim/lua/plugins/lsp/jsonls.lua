-- Schemas (json, yaml)
-- Autocompletion for jsonls/yamls
return {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    opts = function(_, opts)
        local schemastore = require("schemastore")
        local schemas = schemastore.json.schemas()

        -- local custom_schemas =  { }
        -- for schema_url, filenames in pairs(custom_schemas) do
        --     for _, filename in ipairs(filenames) do
        --         table.insert(schemas[schema_url], filename)
        --     end
        -- end

        return vim.tbl_deep_extend("force", opts, {
            servers = {
                jsonls = {
                    json = {
                        schemas = schemas,
                        validate = { enable = true },
                    },
                },
            }
        })
    end

}
