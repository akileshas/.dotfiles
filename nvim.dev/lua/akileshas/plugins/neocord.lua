-- plugin options
local options = {
	logo_tooltip = "nvim",
}

-- plugin keymaps
local keymaps = {}

-- plugin configuration
return {
	"IogaMaster/neocord",
	lazy = true,
	event = "VeryLazy",
	opts = options,
	keys = keymaps,
}
