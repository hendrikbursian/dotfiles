-- Obsidian
return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	cmd = {
		"ObsidianOpen",
		"ObsidianNew",
		"ObsidianQuickSwitch",
		"ObsidianFollowLink",
		"ObsidianBacklinks",
		"ObsidianToday",
		"ObsidianYesterday",
		"ObsidianTemplate",
		"ObsidianSearch",
		"ObsidianLink",
		"ObsidianLinkNew",
		"ObsidianWorkspace",
	},
        -- stylua: ignore
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notizen/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notizen/**.md",
		},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-treesitter",
			opts = {
				ensure_installed = { "markdown", "markdown_inline" },
				highlight = {
					enable = true,
					additionsal_vim_regex_highlighting = { "markdown" },
				},
			},
		},
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Notizen/",
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
			-- Where to put new notes created from completion. Valid options are
			--  * "current_dir" - put new notes in same directory as the current buffer.
			--  * "notes_subdir" - put new notes in the default notes subdirectory.
			new_notes_location = "current_dir",

			-- Whether to add the output of the node_id_func to new notes in autocompletion.
			-- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
			prepend_note_id = true,
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},
		overwrite_mappings = false,
		finder = "telescope.nvim",
	},
}
