-- for convenience
local api = vim.api
local fn = vim.fn
local v = vim.v

-- dashboard header
local dashboard_header = [[
   ____________________________________
  /   Cook your code with precision,   \
  |    spice it with logic,              |
  |    and serve it with clarity,        |
  |    so that no reviewer,              |
  |    dares to reject your              |
  \    masterpiece !!!                  /
  -------------------------------------
\
  \
   \
        ___
       (.. |
       (<> |
       / __  \
       ( /  \ /|
      _/\ __)/_)
      \/-_____\/
]]

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	animate = {
		enabled = false,
	},
	bigfile = {
		enabled = true,
		notify = true,
		size = 1.5 * 1024 * 1024,
		line_length = 1000,
	},
	bufdelete = {
		enabled = true,
	},
	dashboard = {
		enabled = true,
		row = 1,
		col = nil,
		preset = {
			keys = {},
			header = dashboard_header,
		},
		sections = {
			{
				section = "header",
				padding = { 1, 1 },
			},
			{
				section = "startup",
			},
		},
	},
	debug = {
		enabled = true,
	},
	dim = {
		enabled = true,
		scope = {
			min_size = 5,
			max_size = 20,
			siblings = true,
		},
	},
	explorer = {
		enabled = true,
		replace_netrw = false,
	},
	git = {
		enabled = true,
	},
	gitbrowse = {
		enabled = true,
		notify = true,
	},
	image = {
		enabled = true,
	},
	indent = {
		enabled = false,
	},
	input = {
		enabled = true,
	},
	layout = {
		enabled = true,
	},
	lazygit = {
		enabled = true,
		configure = true,
	},
	notifier = {
		enabled = true,
		timeout = 3000,
		top_down = true,
	},
	notify = {
		enabled = true,
	},
	picker = {
		enabled = true,
	},
}

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"folke/snacks.nvim",
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
