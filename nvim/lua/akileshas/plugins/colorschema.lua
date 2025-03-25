-- plugin options
local options = {
	style = "deep",
	transparent = true,
	term_colors = true,
	lualine = {
		transparent = true,
	},
}

-- plugin keymaps
local keymaps = {}

-- plugin init function
local function init()
	local onedark = require("onedark")

	-- load the theme
	onedark.load()
end

-- plugin configurations
return {
	"navarasu/onedark.nvim",
	priority = 1000,
	lazy = false,
	opts = options,
	keys = keymaps,
	init = init,
}
