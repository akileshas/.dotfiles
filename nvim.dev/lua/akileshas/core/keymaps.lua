-- for convenience
local keymap = vim.keymap
local module = require("akileshas.core.modules")

keymap.set("i", "jj", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "exit insert mode with jj",
})

keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>", {
	noremap = true,
	silent = true,
	desc = "clear search highlights",
})

return {}
