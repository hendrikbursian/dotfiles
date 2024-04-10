local lsp_config = require("lspconfig")

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

	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

    -- stylua: ignore start

	nmap("<leader>vrn", vim.lsp.buf.rename, "Vim Re[n]ame")
	nmap("<leader>.", vim.lsp.buf.code_action, "Code Action (Habit from VSCode <C-.>)")

	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>k", vim.lsp.buf.signature_help, "Signature Help")

	nmap("<leader>ct", vim.lsp.buf.incoming_calls, "Incoming Calls")

	-- Telescope
	nmap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
	nmap("gi", require("telescope.builtin").lsp_implementations, "Goto Implementation")
	nmap("gr", require("hendrik.telescope").lsp_references, "Goto References")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type Definition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
	nmap("<leader>K", function() vim.lsp.inlay_hint(0, nil) end, "Toggle Inlay Hints")

	-- Lesser used LSP functionality
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
	nmap("<leader>wl", function() vim.print(vim.lsp.buf.list_workspace_folders()) end, "Workspace List Folders")

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
