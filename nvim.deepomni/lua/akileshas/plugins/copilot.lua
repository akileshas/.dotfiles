return {
	"github/copilot.vim",
	config = function()
		-- for convenience
		local keymap = vim.keymap
		local global = vim.g

		keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		global.copilot_no_tab_map = true
	end,
}
