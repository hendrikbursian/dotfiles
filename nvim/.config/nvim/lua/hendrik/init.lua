require("hendrik.telescope")
require("hendrik.lsp")
require("hendrik.luasnip")

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end
