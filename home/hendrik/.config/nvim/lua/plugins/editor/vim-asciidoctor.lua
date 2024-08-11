return {
	"habamax/vim-asciidoctor",
	event = "VeryLazy",
	keys = {
		{ "<leader>aP", ":AsciidoctorOpenPDF<CR>", ft = "asciidoc" },
		{ "<leader>aH", ":AsciidoctorOpenHTML<CR>", ft = "asciidoc" },
		{ "<leader>aX", ":AsciidoctorOpenDOCX<CR>", ft = "asciidoc" },
		{ "<leader>ah", ":Asciidoctor2HTML<CR>", ft = "asciidoc" },
		{ "<leader>ap", ":Asciidoctor2PDF<CR>", ft = "asciidoc" },
		{ "<leader>ax", ":Asciidoctor2DOCX<CR>", ft = "asciidoc" },
		{ "<leader>p", ":AsciidoctorPasteImage<CR>", ft = "asciidoc" },
	},
}
