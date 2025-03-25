-- plugin options
local options = {
	logo_tooltip = "nvim",
}

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
	"IogaMaster/neocord",
	lazy = true,
	event = "VeryLazy",
	opts = options,
	keys = keymaps,
}
