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

-- for convenience
local fn = vim.fn
local api = vim.api

-- plugin options
local options = {
	animate = {},
	bigfile = {
		enabled = true,
	},
	dashboard = {
		enabled = true,
		row = 1,
		preset = {
			keys = {},
			header = dashboard_header,
		},
		sections = {
			{ section = "header" },
		},
	},
	dim = {},
	explorer = {
		enabled = false,
	},
	gitbrowse = {},
	image = {
		enabled = true,
	},
	indent = {
		enabled = false,
	},
	input = {
		enabled = true,
	},
	layout = {},
	lazygit = {},
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = {
		enabled = true,
		matcher = {
			frecency = true,
		},
	},
	profiler = {},
	quickfile = {
		enabled = true,
	},
	scope = {
		enabled = true,
	},
	scratch = {},
	scroll = {
		enabled = false,
	},
	statuscolumn = {
		enabled = true,
	},
	terminal = {},
	toggle = {},
	win = {},
	words = {
		enabled = true,
	},
	zen = {},
	styles = {},
}

-- plugin keymaps
local keymaps = {
	-- general keymaps
	{
		"<leader><space>",
		mode = "n",
		function()
			Snacks.picker.smart()
		end,
		noremap = true,
		silent = true,
		desc = "open the picker",
	},
	{
		"<leader>an",
		mode = "n",
		function()
			Snacks.picker.notifications()
		end,
		noremap = true,
		silent = true,
		desc = "show all notifications history",
	},
	{
		"<leader>hn",
		mode = "n",
		function()
			Snacks.notifier.hide()
		end,
		noremap = true,
		silent = true,
		desc = "hide the notification",
	},

	-- git keymaps
	{
		"<leader>g?",
		mode = "n",
		function()
			Snacks.git.blame_line()
		end,
		noremap = true,
		silent = true,
		desc = "blame the current line",
	},
	{
		"<leader>gb",
		mode = "n",
		function()
			Snacks.picker.git_branches()
		end,
		noremap = true,
		silent = true,
		desc = "find the git branches",
	},
	{
		"<leader>gB",
		mode = { "n", "v" },
		function()
			Snacks.gitbrowse()
		end,
		noremap = true,
		silent = true,
		desc = "open the current buffer in the browser",
	},
	{
		"<leader>gl",
		mode = "n",
		function()
			Snacks.picker.git_log()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log",
	},
	{
		"<leader>gL",
		mode = "n",
		function()
			Snacks.picker.git_log_line()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log for the current line",
	},
	{
		"<leader>gf",
		mode = "n",
		function()
			Snacks.picker.git_log_file()
		end,
		noremap = true,
		silent = true,
		desc = "find the git log for the current file",
	},
	{
		"<leader>gs",
		mode = "n",
		function()
			Snacks.picker.git_status()
		end,
		noremap = true,
		silent = true,
		desc = "find the git status",
	},
	{
		"<leader>gS",
		mode = "n",
		function()
			Snacks.picker.git_stash()
		end,
		noremap = true,
		silent = true,
		desc = "find the git stash",
	},
	{
		"<leader>gd",
		mode = "n",
		function()
			Snacks.picker.git_diff()
		end,
		noremap = true,
		silent = true,
		desc = "find the git diff",
	},
	{
		"<leader>gg",
		mode = "n",
		function()
			Snacks.lazygit()
		end,
		noremap = true,
		silent = true,
		desc = "open lazygit",
	},

	-- file find keymaps
	{
		"<leader>fb",
		mode = "n",
		function()
			Snacks.picker.buffers()
		end,
		noremap = true,
		silent = true,
		desc = "find the open buffers",
	},
	{
		"<leader>fc",
		mode = "n",
		function()
			Snacks.picker.files({
				cwd = fn.stdpath("config"),
			})
		end,
		noremap = true,
		silent = true,
		desc = "find the files in the config directory",
	},
	{
		"<leader>ff",
		mode = "n",
		function()
			Snacks.picker.files({
				show_empty = true,
				hidden = true,
				ignored = true,
				follow = true,
			})
		end,
		noremap = true,
		silent = true,
		desc = "find the files in the current directory",
	},
	{
		"<leader>fg",
		mode = "n",
		function()
			Snacks.picker.git_files()
		end,
		noremap = true,
		silent = true,
		desc = "find the files in the git repository",
	},
	{
		"<leader>fp",
		mode = "n",
		function()
			Snacks.picker.projects()
		end,
		noremap = true,
		silent = true,
		desc = "find the projects",
	},
	{
		"<leader>fr",
		mode = "n",
		function()
			Snacks.picker.recent()
		end,
		noremap = true,
		silent = true,
		desc = "find the recent files",
	},

	-- search keymaps
	{
		"<leader>sb",
		mode = "n",
		function()
			Snacks.picker.lines()
		end,
		noremap = true,
		silent = true,
		desc = "search for a string in the current buffer",
	},
	{
		"<leader>sB",
		mode = "n",
		function()
			Snacks.picker.grep_buffers()
		end,
		noremap = true,
		silent = true,
		desc = "search for a string in all open buffers",
	},
	{
		"<leader>sg",
		mode = "n",
		function()
			Snacks.picker.grep({
				show_empty = true,
				hidden = true,
				ignored = true,
				follow = true,
			})
		end,
		noremap = true,
		silent = true,
		desc = "search for a string in the current directory",
	},
	{
		"<leader>sw",
		mode = "n",
		function()
			Snacks.picker.grep_word()
		end,
		noremap = true,
		silent = true,
		desc = "search for the word under the cursor",
	},
	{
		'<leader>s"',
		mode = "n",
		function()
			Snacks.picker.registers()
		end,
		noremap = true,
		silent = true,
		desc = "search for a register",
	},
	{
		"<leader>s/",
		mode = "n",
		function()
			Snacks.picker.search_history()
		end,
		noremap = true,
		silent = true,
		desc = "search history",
	},
	{
		"<leader>sa",
		mode = "n",
		function()
			Snacks.picker.autocmds()
		end,
		noremap = true,
		silent = true,
		desc = "search for autocmds",
	},
	{
		"<leader>sc",
		mode = "n",
		function()
			Snacks.picker.command_history()
		end,
		noremap = true,
		silent = true,
		desc = "search for commands history",
	},
	{
		"<leader>sC",
		mode = "n",
		function()
			Snacks.picker.commands()
		end,
		noremap = true,
		silent = true,
		desc = "search for commands",
	},
	{
		"<leader>sd",
		mode = "n",
		function()
			Snacks.picker.diagnostics()
		end,
		noremap = true,
		silent = true,
		desc = "search for diagnostics",
	},
	{
		"<leader>sD",
		mode = "n",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		noremap = true,
		silent = true,
		desc = "search for diagnostics in the current buffer",
	},
	{
		"<leader>s?",
		mode = "n",
		function()
			Snacks.picker.help()
		end,
		noremap = true,
		silent = true,
		desc = "search for help",
	},
	{
		"<leader>sH",
		mode = "n",
		function()
			Snacks.picker.highlights()
		end,
		noremap = true,
		silent = true,
		desc = "search for highlights",
	},
	{
		"<leader>si",
		mode = "n",
		function()
			Snacks.picker.icons()
		end,
		noremap = true,
		silent = true,
		desc = "search for icons",
	},
	{
		"<leader>sj",
		mode = "n",
		function()
			Snacks.picker.jumps()
		end,
		noremap = true,
		silent = true,
		desc = "search for jumps",
	},
	{
		"<leader>sk",
		mode = "n",
		function()
			Snacks.picker.keymaps()
		end,
		noremap = true,
		silent = true,
		desc = "search for keymaps",
	},
	{
		"<leader>sl",
		mode = "n",
		function()
			Snacks.picker.loclist()
		end,
		noremap = true,
		silent = true,
		desc = "search for loclist",
	},
	{
		"<leader>sm",
		mode = "n",
		function()
			Snacks.picker.man()
		end,
		noremap = true,
		silent = true,
		desc = "search the man pages",
	},
	{
		"<leader>sM",
		mode = "n",
		function()
			Snacks.picker.marks()
		end,
		noremap = true,
		silent = true,
		desc = "search for marks",
	},
	{
		"<leader>sp",
		mode = "n",
		function()
			Snacks.picker.lazy()
		end,
		noremap = true,
		silent = true,
		desc = "search for plugins specs",
	},
	{
		"<leader>sq",
		mode = "n",
		function()
			Snacks.picker.qflist()
		end,
		noremap = true,
		silent = true,
		desc = "search for qflist",
	},
	{
		"<leader>sr",
		mode = "n",
		function()
			Snacks.picker.resume()
		end,
		noremap = true,
		silent = true,
		desc = "resume the last search",
	},
	{
		"<leader>su",
		mode = "n",
		function()
			Snacks.picker.undo()
		end,
		noremap = true,
		silent = true,
		desc = "search for undo history",
	},
	{
		"<leader>sz",
		mode = "n",
		function()
			Snacks.picker.zoxide()
		end,
		noremap = true,
		silent = true,
		desc = "search for zoxide",
	},

	-- utility keymaps
	{
		"<leader>z",
		mode = "n",
		function()
			Snacks.zen()
		end,
		noremap = true,
		silent = true,
		desc = "toggle zen mode",
	},
	{
		"<leader>Z",
		mode = "n",
		function()
			Snacks.zen.zoom()
		end,
		noremap = true,
		silent = true,
		desc = "toggle zoom mode",
	},
	{
		"<leader>bd",
		mode = "n",
		function()
			Snacks.bufdelete()
		end,
		noremap = true,
		silent = true,
		desc = "delete the current buffer",
	},
	{
		"<leader>cR",
		mode = "n",
		function()
			Snacks.rename.rename_file()
		end,
		noremap = true,
		silent = true,
		desc = "rename the current file",
	},
	{
		"]]",
		mode = { "n", "t" },
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		noremap = true,
		silent = true,
		desc = "jump to the next reference",
	},
	{
		"[[",
		mode = { "n", "t" },
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		noremap = true,
		silent = true,
		desc = "jump to the previous reference",
	},
}

-- plugin init function
local function init()
	-- autocmd for the lazy event
	api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			-- setup some globals for debugging (lazy-loaded)
			_G.dd = function(...)
				Snacks.debug.inspect(...)
			end
			_G.bt = function()
				Snacks.debug.backtrace()
			end

			-- override print to use snacks for `:=` command
			vim.print = _G.dd
		end,
	})
end

-- plugin configuration
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = options,
	keys = keymaps,
	init = init,
}
