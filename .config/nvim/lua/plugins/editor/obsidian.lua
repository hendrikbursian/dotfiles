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

		-- Where to put new notes created from completion. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "current_dir",
		completion = {
			nvim_cmp = true,
			min_chars = 2,

			-- Optional, customize how wiki links are formatted. You can set this to one of:
			--  * "use_alias_only", e.g. '[[Foo Bar]]'
			--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
			--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
			--  * "use_path_only", e.g. '[[foo-bar.md]]'
			-- Or you can set it to a function that takes a table of options and returns a string, like this:
			wiki_link_func = "prepend_note_id",
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
		finder = "telescope.nvim",
	},
}
