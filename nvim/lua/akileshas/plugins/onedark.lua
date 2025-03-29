-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function()
	-- for convenience
	local onedark = require("onedark")

	-- load the theme
	onedark.load()
end

-- plugin opts
local opts = {
	style = "deep",
	transparent = true,
	term_colors = true,
	ending_tildes = false,
	cmp_itemkind_reverse = false,
	toggle_style_key = "<leader>cs",
	toggle_style_list = {
		"dark",
		"darker",
		"cool",
		"deep",
		"warm",
		"warmer",
		"light",
	},
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
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

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"navarasu/onedark.nvim",
	version = "*",
	enabled = true,
	lazy = false,
	priority = 1000,
	event = {},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	keys = keys,
}
