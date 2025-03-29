-- textobject options
local textobjects = {
	select = {
		enable = true,
		lookahead = true,
		keymaps = {},
		selection_modes = {},
		include_surrounding_whitespace = true,
	},
	swap = {
		enable = true,
		swap_next = {},
		swap_previous = {},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {},
		goto_next_end = {},
		goto_previous_start = {},
		goto_previous_end = {},
		goto_next = {},
		goto_previous = {},
	},
}

-- plugin dependencies
local dependencies = {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	ensure_installed = "all",
	sync_install = false,
	auto_install = true,
	ignore_install = {},
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<BS>",
		},
	},
	indent = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
	textobjects = textobjects,
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local treesitter = require("nvim-treesitter.configs")
	local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

	if opts == nil then
		opts = {}
	end

	-- configure treesitter
	treesitter.setup(opts)
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"nvim-treesitter/nvim-treesitter",
	version = "*",
	enabled = true,
	lazy = true,
	event = {
		"BufReadPost",
		"BufNewFile",
	},
	cmd = {},
	ft = {},
	build = {
		":TSUpdate",
	},
	dependencies = dependencies,
	init = init,
	opts = opts,
	config = config,
	keys = keys,
}
