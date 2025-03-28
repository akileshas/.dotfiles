-- plugin dependencies
local dependencies = {}

-- plugin options
local opts = {
	auto_save = nil,
	disable_on_zoom = true,
	mux = "auto",
}

-- plugin keymaps
local keys = {
	{
		"<C-h>",
		mode = { "" },
		function()
			require("Navigator").left()
		end,
		noremap = true,
		silent = true,
		desc = "move to the left mux pane",
	},
	{
		"<C-l>",
		mode = { "" },
		function()
			require("Navigator").right()
		end,
		noremap = true,
		silent = true,
		desc = "move to the right mux pane",
	},
	{
		"<C-j>",
		mode = { "" },
		function()
			require("Navigator").down()
		end,
		noremap = true,
		silent = true,
		desc = "move to the down mux pane",
	},
	{
		"<C-k>",
		mode = { "" },
		function()
			require("Navigator").up()
		end,
		noremap = true,
		silent = true,
		desc = "move to the up mux pane",
	},
	{
		"<C-p>",
		mode = { "" },
		function()
			require("Navigator").previous()
		end,
		noremap = true,
		silent = true,
		desc = "move to the previous mux pane",
	},
}

-- plugin init function
local init = function() end

-- plugin configurations
return {
	"numToStr/Navigator.nvim",
	version = "*",
	enabled = true,
	lazy = true,
	event = {},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	keys = keys,
}
