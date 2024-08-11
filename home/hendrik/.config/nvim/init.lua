require("config.options")

require("modules.lazy").setup()

require("config.keymaps")
require("config.autocommands")
require("config.filetypes")

require("modules.colorscheme").init()
