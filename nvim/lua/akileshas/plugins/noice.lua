-- plugin dependencies
local dependencies = {
	{
		"MunifTanjim/nui.nvim",
	},
}

-- plugin opts
local opts = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = false,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
}

-- plugin keys
local keys = {}

-- plugin init function
local init = function() end

-- plugin configurations
return {
	"folke/noice.nvim",
	version = "*",
	enabled = true,
	lazy = true,
	event = {
		"VeryLazy",
	},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	keys = keys,
}
