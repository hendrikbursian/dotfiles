local vue_defaults = {
	language_server = nil,
	typescript_plugin = nil,
	typescript_lib = nil,
}

require("neoconf.plugins").register({
	on_schema = function(schema)
		schema:set("vue.language_server", {
			description = "Path to @vue/language-service binary",
			type = "string",
		})
		schema:set("vue.typescript_plugin", {
			description = "Path to @vue/typescript-plugin",
			type = "string",
		})
		schema:set("vue.typescript_lib", {
			description = "Path to global typescript lib",
			type = "string",
		})
	end,
})

local M = {}

M.get_vue_config = function()
	return require("neoconf").get("vue", vue_defaults)
end

return M
