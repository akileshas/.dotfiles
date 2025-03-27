-- plugin options
local options = {
	style = "deep",
	transparent = true,
	term_colors = true,
	ending_tildes = false,
	cmp_itemkind_reverse = false,
	toggle_style_key = "<leader>cs",
	toggle_style_list = {
		'dark',
		'darker',
		'cool',
		'warm',
		'warmer',
		'deep',
		'light',
	},
	code_style = {
		comments = 'italic',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		strings = 'none',
	},
	lualine = {
		transparent = true,
	},
	diagnostics = {
		darker = true,
		undercurl = true,
		background = true,
	},
}

-- plugin keymaps
local keymaps = {}

-- plugin init function
local init = function()
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
