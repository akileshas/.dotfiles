return {
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitted.setup({
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enabe = true,
			},
		})
	end,
}
