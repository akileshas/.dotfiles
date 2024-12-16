return {
	"IogaMaster/neocord",
	event = "VeryLazy",
	config = function()
		local neocord = require("neocord")
		neocord.setup({
			logo_tooltip = "Skillissue",
		})
	end,
}
