local utils = require("hendrik.utils")

-- Surround
return {
	"kylechui/nvim-surround",
	event = utils.FileEvent,
	opts = {
		move_cursor = false,
	},
}
