-- plugin options
local options = {}

-- plugin keymaps
local keymaps = {
	-- keymap to toggle stay-centered.nvim
	{
		"<leader>tc",
		mode = "n",
		function()
			require("stay-centered").toggle()
		end,
		noremap = true,
		silent = true,
		desc = "toggle stay-centered.nvim",
	},
}

-- plugin configuration
return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	opts = options,
	keys = keymaps,
}
