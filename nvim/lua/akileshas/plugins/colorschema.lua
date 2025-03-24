return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		local onedark = require("onedark")
		onedark.setup({
			style = "deep",
			transparent = true,
			term_colors = true,

			lualine = {
				transparent = true,
			},
		})

		-- Load the theme
		onedark.load()
	end,
}
