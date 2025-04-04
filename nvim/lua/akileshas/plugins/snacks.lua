-- for convenience
local api = vim.api
local fn = vim.fn
local log = vim.log
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
		width = 60,
		row = 1,
		col = nil,
		pane_gap = 4,
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
		formats = {
			"png",
			"jpg",
			"jpeg",
			"gif",
			"bmp",
			"webp",
			"tiff",
			"heic",
			"avif",
			"mp4",
			"mov",
			"avi",
			"mkv",
			"webm",
			"pdf",
		},
		doc = {
			enabled = true,
			inline = true,
			float = true,
			max_width = 80,
			max_height = 40,
		},
		wo = {
			wrap = false,
			number = false,
			relativenumber = false,
			cursorcolumn = false,
			signcolumn = "no",
			foldcolumn = "0",
			list = false,
			spell = false,
			statuscolumn = "",
		},
	},
	indent = {
		enabled = true,
		indent = {
			enabled = true,
			priority = 1,
			only_scope = false,
			only_current = false,
			char = "┆",
		},
		scope = {
			enabled = true,
			priority = 200,
			underline = false,
			only_current = false,
			char = "┆",
		},
		chunk = {
			enabled = false,
			priority = 200,
			only_current = false,
			char = {
				-- corner_top = "┌",
				-- corner_bottom = "└",
				corner_top = "╭",
				corner_bottom = "╰",
				horizontal = "─",
				vertical = "│",
				arrow = ">",
			},
		},
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
		width = {
			min = 40,
			max = 0.4
		},
		height = {
			min = 1,
			max = 0.6
		},
		margin = {
			top = 0,
			right = 1,
			bottom = 0
		},
		padding = true,
		sort = {
			"level",
			"added",
		},
		level = log.levels.TRACE,
		style = "compact",
		top_down = true,
		date_format = "%R",
		more_format = " ↓ %d lines ",
		refresh = 50,
	},
	notify = {
		enabled = true,
	},
	picker = {
		enabled = true,
		sources = {},
		layout = {
			cycle = true,
		},
		matcher = {
			fuzzy = true,
			smartcase = true,
			ignorecase = true,
			sort_empty = false,
			filename_bonus = true,
			file_pos = true,
			cwd_bonus = false,
			frecency = true,
			history_bonus = false,
		},
		ui_select = true,
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
