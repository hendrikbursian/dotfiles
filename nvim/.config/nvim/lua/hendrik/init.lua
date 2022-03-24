function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
		bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end

Nnoremap = CreateNoremap("n", { noremap = true })
Inoremap = CreateNoremap("i", { noremap = true })

require("hendrik.utils")
require("hendrik.telescope")
require("hendrik.lsp")
require("hendrik.luasnip")
require("hendrik.status")
require("hendrik.git")
require("hendrik.tree")

