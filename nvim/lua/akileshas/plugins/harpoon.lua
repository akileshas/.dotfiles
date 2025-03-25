-- plugin options
local options = {}

-- helper function to define keymaps for harpoon navigation
local function keymaps_for_navigation(keymaps, num)
	for i = 1, num do
		table.insert(keymaps, {
			"<leader>" .. i,
			mode = "n",
			function()
				require("harpoon.ui").nav_file(i)
			end,
			noremap = true,
			silent = true,
			desc = "navigate to harpoon file " .. i,
		})
	end
end

-- plugin keymaps
local keymaps = {
	-- keymap to add file to harpoon
	{
		"<leader>a",
		mode = "n",
		function()
			require("harpoon.mark").add_file()
		end,
		noremap = true,
		silent = true,
		desc = "add file to harpoon",
	},
	-- keymap to toggle harpoon quick menu
	{
		"<c-a>",
		mode = "n",
		function()
			require("harpoon.ui").toggle_quick_menu()
		end,
		noremap = true,
		silent = true,
		desc = "toggle harpoon quick menu",
	},
}

-- add keymaps for navigating to harpoon files (1-9)
keymaps_for_navigation(keymaps, 9)

-- add keymap for navigating to file 10
table.insert(keymaps, {
	"<leader>0",
	mode = "n",
	function()
		require("harpoon.ui").nav_file(10)
	end,
	noremap = true,
	silent = true,
	desc = "navigate to harpoon file 10",
})

-- plugin configurations
return {
	"theprimeagen/harpoon",
	lazy = true,
	opts = options,
	keys = keymaps,
}
