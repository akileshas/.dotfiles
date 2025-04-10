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
		focus = "input",
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
	profiler = {
		enabled = true,
	},
	quickfile = {
		enabled = true,
	},
	rename = {
		enabled = true,
	},
	scope = {
		enabled = false,
	},
	scratch = {
		enabled = true,
	},
	scroll = {
		enabled = false,
	},
	statuscolumn = {
		enabled = false,
	},
	terminal = {
		enabled = true,
	},
	toggle = {
		enabled = false,
	},
	util = {
		enabled = true,
	},
	win = {
		enabled = true,
	},
	words = {
		enabled = true,
	},
	zen = {
		enabled = true,
		toggles = {
			dim = true,
			git_signs = true,
			mini_diff_signs = true,
			diagnostics = true,
			inlay_hints = true,
		},
		show = {
			statusline = true,
			tabline = false,
		},
		zoom = {
			toggles = {
				dim = false,
				git_signs = true,
				mini_diff_signs = true,
				diagnostics = true,
				inlay_hints = true,
			},
			show = {
				statusline = true,
				tabline = true,
			},
		},
	},
	styles = {},
}

-- plugin keys
local keys = {
	-- git keymaps
	{
		"<leader>gb",
		mode = { "n" },
		function()
			Snacks.git.blame_line()
		end,
		noremap = true,
		silent = true,
		desc = "blame the current line",
	},
	{
		"<leader>gB",
		mode = { "n" },
		function()
			Snacks.picker.git_branches({
				all = true,
			})
		end,
		noremap = true,
		silent = true,
		desc = "find the git branches",
	},
	{
		"<leader>go",
		mode = { "n", "v", "x" },
		function()
			Snacks.gitbrowse.open()
		end,
		noremap = true,
		silent = true,
		desc = "open the current buffer in the browser",
	},
	{
		"<leader>gl",
		mode = { "n" },
		function()
			Snacks.picker.git_log()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log",
	},
	{
		"<leader>gL",
		mode = { "n" },
		function()
			Snacks.picker.git_log_line()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log for the current line",
	},
	{
		"<leader>gf",
		mode = { "n" },
		function()
			Snacks.picker.git_log_file()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log for the current file",
	},
	{
		"<leader>gs",
		mode = { "n" },
		function()
			Snacks.picker.git_status()
		end,
		noremap = true,
		silent = true,
		desc = "find the git status",
	},
	{
		"<leader>gS",
		mode = { "n" },
		function()
			Snacks.picker.git_stash()
		end,
		noremap = true,
		silent = true,
		desc = "find the git stash",
	},
	{
		"<leader>gd",
		mode = { "n" },
		function()
			Snacks.picker.git_diff()
		end,
		noremap = true,
		silent = true,
		desc = "find the git diff",
	},
	{
		"<leader>ggg",
		mode = { "n" },
		function()
			Snacks.lazygit.open()
		end,
		noremap = true,
		silent = true,
		desc = "open lazygit",
	},
	{
		"<leader>ggl",
		mode = { "n" },
		function()
			Snacks.lazygit.log()
		end,
		noremap = true,
		silent = true,
		desc = "open lazygit with log view",
	},
	{
		"<leader>ggf",
		mode = { "n" },
		function()
			Snacks.lazygit.log_file()
		end,
		noremap = true,
		silent = true,
		desc = "open lazygit with the log of the current file",
	},

	-- find files keymaps
	{
		"<leader>fb",
		mode = { "n" },
		function()
			Snacks.picker.buffers()
		end,
		noremap = true,
		silent = true,
		desc = "find the open buffers",
	},
	{
		"<leader>fs",
		mode = { "n" },
		function()
			Snacks.picker.smart()
		end,
		noremap = true,
		silent = true,
		desc = "open the smart picker",
	},
	{
		"<leader>fc",
		mode = { "n" },
		function()
			Snacks.picker.files({
				show_empty = true,
				hidden = true,
				ignored = true,
				follow = true,
				supports_live = true,
				cwd = fn.stdpath("config"),
			})
		end,
		noremap = true,
		silent = true,
		desc = "find files in the nvim configuration directory",
	},
	{
		"<leader>ff",
		mode = { "n" },
		function()
			Snacks.picker.files({
				show_empty = true,
				hidden = true,
				ignored = true,
				follow = true,
				supports_live = true,
			})
		end,
		noremap = true,
		silent = true,
		desc = "find files in the current working directory",
	},
	{
		"<leader>fg",
		mode = { "n" },
		function()
			Snacks.picker.git_files()
		end,
		noremap = true,
		silent = true,
		desc = "find files in the current git repository",
	},
	{
		"<leader>fp",
		mode = { "n" },
		function()
			Snacks.picker.projects()
		end,
		noremap = true,
		silent = true,
		desc = "find the projects",
	},
	{
		"<leader>fr",
		mode = { "n" },
		function()
			Snacks.picker.recent()
		end,
		noremap = true,
		silent = true,
		desc = "find the recent files",
	},

	-- utilities keymaps
	{
		"<localleader>ss",
		mode = { "n" },
		function()
			Snacks.scratch()
		end,
		noremap = true,
		silent = true,
		desc = "toggle the scratch buffer",
	},
	{
		"<localleader>sl",
		mode = { "n" },
		function()
			Snacks.scratch.select()
		end,
		noremap = true,
		silent = true,
		desc = "select a scratch buffer from a list of scratch buffers",
	},
	{
		"<leader>nh",
		mode = { "n" },
		function()
			Snacks.picker.notifications()
		end,
		noremap = true,
		silent = true,
		desc = "show all notifications history in picker",
	},
	{
		"<leader>nH",
		mode = { "n" },
		function()
			Snacks.notifier.show_history()
		end,
		noremap = true,
		silent = true,
		desc = "show all notifications history",
	},
	{
		"<leader>hn",
		mode = { "n" },
		function()
			Snacks.notifier.hide()
		end,
		noremap = true,
		silent = true,
		desc = "hide all the notifications",
	},
	{
		"<leader>ee",
		mode = { "n" },
		function()
			Snacks.explorer.open()
		end,
		noremap = true,
		silent = true,
		desc = "open the snacks explorer",
	},
	{
		"<leader>wz",
		mode = { "n" },
		function()
			Snacks.zen.zoom()
		end,
		noremap = true,
		silent = true,
		desc = "toggle zoom mode",
	},
	{
		"<leader>wZ",
		mode = { "n" },
		function()
			Snacks.zen.zen()
		end,
		noremap = true,
		silent = true,
		desc = "toggle zen mode",
	},
	{
		"<leader>bdd",
		mode = { "n" },
		function()
			Snacks.bufdelete.delete()
		end,
		noremap = true,
		silent = true,
		desc = "delete the current buffer",
	},
	{
		"<leader>bdo",
		mode = { "n" },
		function()
			Snacks.bufdelete.other()
		end,
		noremap = true,
		silent = true,
		desc = "delete the buffers except the current one",
	},
	{
		"<leader>bda",
		mode = { "n" },
		function()
			Snacks.bufdelete.all()
		end,
		noremap = true,
		silent = true,
		desc = "delete all buffers",
	},
	{
		"<leader>cR",
		mode = { "n" },
		function()
			Snacks.rename.rename_file()
		end,
		noremap = true,
		silent = true,
		desc = "rename the current file",
	},
	{
		"<C-x>",
		mode = { "n" },
		function()
			Snacks.terminal.toggle()
		end,
		noremap = true,
		silent = true,
		desc = "toggle terminal",
	},
	{
		"]]",
		mode = { "n", "t" },
		function()
			Snacks.words.jump(v.count1)
		end,
		noremap = true,
		silent = true,
		desc = "jump to the next reference",
	},
	{
		"[[",
		mode = { "n", "t" },
		function()
			Snacks.words.jump(-v.count1)
		end,
		noremap = true,
		silent = true,
		desc = "jump to the previous reference",
	},
}

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
