return {
	"ThePrimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		-- for convenience
		local keymap = vim.keymap

		keymap.set("n", "<leader>a", mark.add_file)
		keymap.set("n", "<C-a>", ui.toggle_quick_menu)

		for i = 1, 10 do
			keymap.set("n", "<leader>" .. i, function()
				ui.nav_file(i)
			end)
		end
	end,
}
