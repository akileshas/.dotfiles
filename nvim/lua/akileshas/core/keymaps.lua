-- for convenience
local keymap = vim.keymap

local module = require("akileshas.core.modules")

keymap.set("i", "jj", "<Esc>", {
	noremap = true,
	silent = true,
	desc = "exit insert mode with jj",
})

keymap.set({ "n", "v", "x" }, "<leader>cl", "<cmd>nohlsearch<CR>", {
	noremap = true,
	silent = true,
	desc = "clear search highlights",
})

keymap.set({ "n", "v", "x" }, "=", "<C-a>", {
	noremap = true,
	silent = true,
	desc = "Increment number",
})

keymap.set({ "n", "v", "x" }, "-", "<C-x>", {
	noremap = true,
	silent = true,
	desc = "Decrement number",
})

keymap.set({ "n", "v", "x" }, "<leader>sv", "<C-w>v", {
	noremap = true,
	silent = true,
	desc = "Split window vertically",
})

keymap.set({ "n", "v", "x" }, "<leader>sh", "<C-w>s", {
	noremap = true,
	silent = true,
	desc = "Split window horizontally",
})

keymap.set({ "n", "v", "x" }, "<leader>se", "<C-w>=", {
	noremap = true,
	silent = true,
	desc = "Make splits equal size",
})

keymap.set({ "n", "v", "x" }, "<leader>sx", "<cmd>close<CR>", {
	noremap = true,
	silent = true,
	desc = "Close current split",
})

keymap.set({ "n", "v", "x" }, "<C-Left>", [[<cmd>vertical resize +5<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window bigger vertically",
})

keymap.set({ "n", "v", "x" }, "<C-Right>", [[<cmd>vertical resize -5<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window smaller vertically",
})

keymap.set({ "n", "v", "x" }, "<C-Up>", [[<cmd>horizontal resize +2<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window bigger horizontally",
})

keymap.set({ "n", "v", "x" }, "<C-Down>", [[<cmd>horizontal resize -2<CR>]], {
	noremap = true,
	silent = true,
	desc = "Make the window smaller horizontally",
})

keymap.set("v", "<", "<gv", {
	noremap = true,
	silent = true,
	desc = "Keep visual mode selection after indenting",
})

keymap.set("v", ">", ">gv", {
	noremap = true,
	silent = true,
	desc = "Keep visual mode selection after indenting",
})

keymap.set({ "n", "v", "x" }, "x", [["_x]], {
	noremap = true,
	silent = true,
	desc = "do not copy on x",
})

keymap.set({ "v", "x" }, "p", [["_dP]], {
	noremap = true,
	silent = true,
	desc = "do not copy on paste",
})

keymap.set({ "n", "v", "x" }, "d", [["_d]], {
	noremap = true,
	silent = true,
	desc = "do not copy on delete",
})

return {}
