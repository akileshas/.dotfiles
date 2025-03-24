-- plugin dependencies
local dependencies = {
	"MunifTanjim/nui.nvim",
}

-- plugin options
local options = {
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
	},
}

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
	"folke/noice.nvim",
	lazy = true,
	event = "VeryLazy",
	dependencies = dependencies,
	opts = options,
	keys = keymaps,
}
