-- plugin dependencies
local dependencies = {
	"giuxtaposition/blink-cmp-copilot",
}

-- plugin options
local options = {
	panel = {
		enabled = false,
	},
	suggestion = {
		enabled = false,
	},
	filetypes = {
		yaml = true,
		markdown = true,
		help = true,
		gitcommit = true,
		gitrebase = true,
		hgcommit = true,
		svn = true,
		cvs = true,
		["."] = true,
	},
	copilot_node_command = "node",
}

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
	"zbirenbaum/copilot.lua",
	lazy = true,
	event = {
		"InsertEnter",
	},
	dependencies = dependencies,
	opts = options,
	keys = keymaps,
}
