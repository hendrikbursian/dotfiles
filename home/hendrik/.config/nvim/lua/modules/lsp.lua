local lsp_config = require("lspconfig")

local function toggle_inlay_hints()
	local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = 0 })
end

local function show_workspace_folders()
	vim.print(vim.lsp.buf.list_workspace_folders())
end

local M = {}

M.get_capabilities = function()
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

	local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		has_cmp and cmp_nvim_lsp.default_capabilities() or {}
	)

	return capabilities
end

M.on_attach = function(_, bufnr)
	-- Thanks!!
	-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/lsp/init.lua
	-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

    -- stylua: ignore start

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,                                         { desc = "Vim Re[n]ame", buffer = bufnr })
	vim.keymap.set("n", "<leader>.",   vim.lsp.buf.code_action,                                    { desc = "Code Action (Habit from VSCode <C-.>)", buffer = bufnr })

	vim.keymap.set("n", "K",           vim.lsp.buf.hover,                                          { desc = "Hover Documentation", buffer = bufnr })

	-- Telescope
	vim.keymap.set("n", "gd",          require("telescope.builtin").lsp_definitions,               { desc = "Goto Definition", buffer = bufnr })
	vim.keymap.set("n", "gi",          require("telescope.builtin").lsp_implementations,           { desc = "Goto Implementation", buffer = bufnr })
	vim.keymap.set("n", "gr",          require("modules.telescope").lsp_references,                { desc = "Goto References", buffer = bufnr })
	vim.keymap.set("n", "<leader>D",   require("telescope.builtin").lsp_type_definitions,          { desc = "Type Definition", buffer = bufnr })
	vim.keymap.set("n", "<leader>ds",  require("telescope.builtin").lsp_document_symbols,          { desc = "Document Symbols", buffer = bufnr })
	vim.keymap.set("n", "<leader>ws",  require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "Workspace Symbols", buffer = bufnr })
    vim.keymap.set("n", "<leader>K",   toggle_inlay_hints,                                         { desc = "Toggle Inlay Hints", buffer = bufnr })
	vim.keymap.set("i", "<C-k>",       vim.lsp.buf.signature_help,                                 { desc = "Signature Help", buffer = bufnr })

	-- Lesser used LSP functionality
	vim.keymap.set("n", "<leader>wa",  vim.lsp.buf.add_workspace_folder,                           { desc = "Workspace Add Folder", buffer = bufnr })
	vim.keymap.set("n", "<leader>wr",  vim.lsp.buf.remove_workspace_folder,                        { desc = "Workspace Remove Folder", buffer = bufnr })
	vim.keymap.set("n", "<leader>wl",  show_workspace_folders,                                     { desc = "Workspace List Folders", buffer = bufnr })

	-- stylua: ignore end
end

M.get_default_server_config = function(settings)
	return {
		capabilities = M.get_capabilities(),
		on_attach = M.on_attach,
		settings = settings,
		flags = {
			debounce_text_changes = 150,
		},
	}
end

M.config_setup = function(server_name, settings)
	local config = M.get_default_server_config(settings)

	lsp_config[server_name].setup(config)
end

return M
