return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	opts = {},
	keys = {
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
	},
}
