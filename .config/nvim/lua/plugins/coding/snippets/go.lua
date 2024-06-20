return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

        -- stylua: ignore
        ls.add_snippets("go", {
            s("test", {
                t("func Test"), i(1), t("(t *testing.T) {"),
                t({"", "    "}), i(2, "t.Fatalf(\"Not implemented\")"),
                t({"", "}"}),
                t({""})
            })
        })
	end,
}
