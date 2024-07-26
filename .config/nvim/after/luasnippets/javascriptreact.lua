local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local snippet_node = ls.snippet_node
local dynamic_node = ls.dynamic_node

local function file_name_node(index, default_file_name)
	default_file_name = default_file_name or ""

	return dynamic_node(index, function(_, parent)
		local file_name = (parent.env or {}).TM_FILENAME or default_file_name
		local core_name = file_name:match("^([%a_-]+)%.?")

		return snippet_node(nil, { i(1, core_name) })
	end, {})
end

-- stylua: ignore
ls.add_snippets("javascriptreact", {
    s('new', {
        t({'import React from \'react\'', ''}),
        t({'', 'export default function '}), file_name_node(1, "Component"), t('() {'),
        t({'', '  return ('}), i(2, '<h1>It works!</h1>'), t(')'),
        t({'', '}'}),
    })
})
