local vim = vim
local validate = vim.validate
local uv = vim.loop

local is_windows = uv.os_uname().version:match("Windows")

-- Maps linters/formatters to their respective mason name for installation
local mason_names = {
	gofmt = false,
	sql_formatter = "sql-formatter",
	rustfmt = false,
}

local M = {}

M.FileEvent = { "BufReadPost", "BufNewFile", "BufWritePre" }

-- https://github.com/neovim/nvim-lspconfig/blob/6428fcab6f3c09e934bc016c329806314384a41e/lua/lspconfig/util.lua
-- Some path utilities
M.path = (function()
	local function escape_wildcards(path)
		return path:gsub("([%[%]%?%*])", "\\%1")
	end

	local function sanitize(path)
		if is_windows then
			path = path:sub(1, 1):upper() .. path:sub(2)
			path = path:gsub("\\", "/")
		end
		return path
	end

	local function exists(filename)
		local stat = uv.fs_stat(filename)
		return stat and stat.type or false
	end

	local function is_dir(filename)
		return exists(filename) == "directory"
	end

	local function is_file(filename)
		return exists(filename) == "file"
	end

	local function is_fs_root(path)
		if is_windows then
			return path:match("^%a:$")
		else
			return path == "/"
		end
	end

	local function is_absolute(filename)
		if is_windows then
			return filename:match("^%a:") or filename:match("^\\\\")
		else
			return filename:match("^/")
		end
	end

	--- @param path string
	--- @return string?
	local function dirname(path)
		local strip_dir_pat = "/([^/]+)$"
		local strip_sep_pat = "/$"
		if not path or #path == 0 then
			return
		end
		local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
		if #result == 0 then
			if is_windows then
				return path:sub(1, 2):upper()
			else
				return "/"
			end
		end
		return result
	end

	local function path_join(...)
		return table.concat(vim.tbl_flatten({ ... }), "/")
	end

	-- Traverse the path calling cb along the way.
	local function traverse_parents(path, cb)
		path = uv.fs_realpath(path)
		local dir = path
		-- Just in case our algo is buggy, don't infinite loop.
		for _ = 1, 100 do
			dir = dirname(dir)
			if not dir then
				return
			end
			-- If we can't ascend further, then stop looking.
			if cb(dir, path) then
				return dir, path
			end
			if is_fs_root(dir) then
				break
			end
		end
	end

	-- Iterate the path until we find the rootdir.
	local function iterate_parents(path)
		local function it(_, v)
			if v and not is_fs_root(v) then
				v = dirname(v)
			else
				return
			end
			if v and uv.fs_realpath(v) then
				return v, path
			else
				return
			end
		end
		return it, path, path
	end

	local function is_descendant(root, path)
		if not path then
			return false
		end

		local function cb(dir, _)
			return dir == root
		end

		local dir, _ = traverse_parents(path, cb)

		return dir == root
	end

	local path_separator = is_windows and ";" or ":"

	return {
		escape_wildcards = escape_wildcards,
		is_dir = is_dir,
		is_file = is_file,
		is_absolute = is_absolute,
		exists = exists,
		dirname = dirname,
		join = path_join,
		sanitize = sanitize,
		traverse_parents = traverse_parents,
		iterate_parents = iterate_parents,
		is_descendant = is_descendant,
		path_separator = path_separator,
	}
end)()

-- Source: https://github.com/neovim/nvim-lspconfig/blob/6428fcab6f3c09e934bc016c329806314384a41e/lua/lspconfig/util.lua
M.search_ancestors = function(startpath, func)
	validate({ func = { func, "f" } })
	if func(startpath) then
		return startpath
	end
	local guard = 100
	for path in M.path.iterate_parents(startpath) do
		-- Prevent infinite recursion if our algorithm breaks
		guard = guard - 1
		if guard == 0 then
			return
		end

		if func(path) then
			return path
		end
	end
end

-- Source: https://github.com/neovim/nvim-lspconfig/blob/6428fcab6f3c09e934bc016c329806314384a41e/lua/lspconfig/util.lua
M.find_git_ancestor = function(startpath)
	return M.search_ancestors(startpath, function(path)
		-- Support git directories and git files (worktrees)
		if M.path.is_dir(M.path.join(path, ".git")) or M.path.is_file(M.path.join(path, ".git")) then
			return path
		end
	end)
end

-- Source: https://github.com/neovim/nvim-lspconfig/blob/6428fcab6f3c09e934bc016c329806314384a41e/lua/lspconfig/util.lua
M.find_package_json_ancestor = function(startpath)
	return M.search_ancestors(startpath, function(path)
		if M.path.is_file(M.path.join(path, "package.json")) then
			return path
		end
	end)
end

M.get_current_file_or_cwd = function()
	local path = vim.fn.argv(0) or vim.api.nvim_buf_get_name(0)
	if path == "" then
		return vim.loop.cwd()
	else
		return path
	end
end

M.get_git_dir_or_cwd = function()
	local path = M.get_current_file_or_cwd()

	return M.find_git_ancestor(path) or vim.loop.cwd()
end

-- Concatenates unique formatters/linters
M.merge_by_ft_table = function(tab, ignore)
	local unique = {}
	for _, values in pairs(tab) do
		for _, value in ipairs(values) do
			if type(value) == "table" then
				for _, sub_value in ipairs(value) do
					unique[sub_value] = true
				end
			else
				unique[value] = true
			end
		end
	end

	for _, name in pairs(ignore) do
		unique[name] = nil
	end

	local result = {}
	for name, value in pairs(unique) do
		if value ~= nil then
			table.insert(result, name)
		end
	end
	return result
end

M.get_mason_name = function(name)
	local mason_name = mason_names[name]
	if type(mason_name) == "string" then
		return mason_name
	elseif mason_name == false then
		return nil
	else
		return name
	end
end

return M
