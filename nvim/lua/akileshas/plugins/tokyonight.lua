-- for convenience
local cmd = vim.cmd

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function()
	-- load the tokyonight color scheme
	cmd("colorscheme tokyonight")
end

-- plugin opts
local opts = {
	style = "night",
	transparent = true,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "transparent",
		floats = "transparent",
	},
	dim_inactive = false,
	cache = true,
	on_colors = function(colors) end,
	on_highlights = function(highlights, colors) end,
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local tokyonight = require("tokyonight")

	-- configure tokyonight
	tokyonight.setup(opts)
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"folke/tokyonight.nvim",
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
	config = config,
	keys = keys,
}
