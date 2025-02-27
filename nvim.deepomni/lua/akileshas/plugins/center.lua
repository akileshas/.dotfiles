return {
	"arnamak/stay-centered.nvim",
	lazy = false,
	config = function()
		local stay_centered = require("stay-centered")
		stay_centered.setup()

		-- for convenience
		local keymap = vim.keymap

		keymap.set({ "n", "v" }, "<leader>tc", require("stay-centered").toggle, {
			desc = "Toggle stay-centered.nvim",
			noremap = true,
			silent = true,
		})
	end,
}
