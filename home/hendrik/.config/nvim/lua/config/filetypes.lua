vim.filetype.add({
	extension = {
		templ = "templ",
	},
	pattern = {
		[".*%.ya?ml.template"] = "yaml",
		[".*%.conf.template"] = "nginx",
		[".*%.blade%.php"] = "blade",
	},
})
