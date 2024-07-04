-- Startscreen
return {
	"mhinz/vim-startify",
	lazy = false,
	config = function()
		local function git_modified()
			local files = vim.fn.systemlist("git ls-files -m 2>/dev/null")
			return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
		end

		local function git_untracked()
			local files = vim.fn.systemlist("git ls-files -o --exclude-standard 2>/dev/null")
			return vim.fn.map(files, "{'line': v:val, 'path': v:val}")
		end

		vim.g.startify_custom_header = {
			"   Home",
			"",
			"   =============================================================================",
		}
		vim.g.startify_enable_special = 0

        -- stylua: ignore
        vim.g.startify_lists = {
            { type = git_modified,  header = { "   Git modified" } },
            { type = "dir",         header = { "   MRU " .. vim.loop.cwd() } },
            { type = "files",       header = { "   MRU" } },
            { type = git_untracked, header = { "   Git untracked" } },
            { type = "bookmarks",   header = { "   Bookmarks" } },
            { type = "commands",    header = { "   Commands" } },
        }
	end,
}
