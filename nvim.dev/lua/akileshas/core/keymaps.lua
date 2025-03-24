-- for convenience
local keymap = vim.keymap

local module = require("akileshas.core.modules")

keymap.set("i", "jj", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "exit insert mode with jj",
})

keymap.set("n", "<leader>cl", "<cmd>nohlsearch<CR>", {
	noremap = true,
	silent = true,
	desc = "clear search highlights",
})

keymap.set("n", "<leader>=", "<C-a>", {
	noremap = true,
	silent = true,
	desc = "Increment number",
})

keymap.set("n", "<leader>-", "<C-x>", {
	noremap = true,
	silent = true,
	desc = "Decrement number",
})

keymap.set("n", "<leader>sv", "<C-w>v", {
	noremap = true,
	silent = true,
	desc = "Split window vertically",
})

keymap.set("n", "<leader>sh", "<C-w>s", {
	noremap = true,
	silent = true,
	desc = "Split window horizontally",
})

keymap.set("n", "<leader>se", "<C-w>=", {
	noremap = true,
	silent = true,
	desc = "Make splits equal size",
})

keymap.set("n", "<leader>sx", "<cmd>close<CR>", {
	noremap = true,
	silent = true,
	desc = "Close current split",
})

keymap.set("n", "<C-Left>", [[<cmd>vertical resize +5<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window bigger vertically",
})

keymap.set("n", "<C-Right>", [[<cmd>vertical resize -5<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window smaller vertically",
})

keymap.set("n", "<C-Up>", [[<cmd>horizontal resize +2<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window bigger horizontally",
})

keymap.set("n", "<C-Down>", [[<cmd>horizontal resize -2<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window smaller horizontally",
})

keymap.set("v", "<", "<gv", {
	silent = true,
	noremap = true,
	desc = "Keep visual mode selection after indenting",
})

keymap.set("v", ">", ">gv", {
	silent = true,
	noremap = true,
	desc = "Keep visual mode selection after indenting",
})

return {}
