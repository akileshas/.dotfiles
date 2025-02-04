return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					"",
					"   ____________________________________                    ",
					"  /   Cook your code with precision,   \\                   ",
					" |    spice it with logic,              |                  ",
					" |    and serve it with clarity—so      |                  ",
					" |    clarity—so that no reviewer       |                  ",
					" |    dares to reject your              |                  ",
					" \\   masterpiece !!!                  /                  ",
					"  ------------------------------------                   ",
					"      \\      ",
					"        \\      ",
					"          \\      ",
					"                 ___      ",
					"                (.. |     ",
					"                (<> |     ",
					"               / __  \\    ",
					"              ( /  \\ /|   ",
					"             _/\\ __)/_)   ",
					"             \\/-_____\\/   ",
					"",
					"",
				},
				center = {
					{
						desc = "",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
