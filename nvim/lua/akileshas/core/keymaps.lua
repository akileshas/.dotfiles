-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- setting a flag to indicate that NERD Fonts are available
vim.g.have_nerd_font = true

local keymap = vim.keymap -- for conciseness

-- define the keymaps

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", {
	desc = "Exit insert mode with jk",
})

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", {
	desc = "Clear search highlights",
})

-- delete single character without copying into register
keymap.set("n", "x", '"_x', {
	desc = "Delete single character without copying",
})

-- increment/decrement numbers
-- increment
keymap.set("n", "<leader>=", "<C-a>", {
	desc = "Increment number",
})
-- decrement
keymap.set("n", "<leader>-", "<C-x>", {
	desc = "Decrement number",
})

-- window management
-- split window vertically
keymap.set("n", "<leader>sv", "<C-w>v", {
	desc = "Split window vertically",
})
-- split window horizontally
keymap.set("n", "<leader>sh", "<C-w>s", {
	desc = "Split window horizontally",
})
-- make split windows equal width & height
keymap.set("n", "<leader>se", "<C-w>=", {
	desc = "Make splits equal size",
})
-- close current split window
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {
	desc = "Close current split",
})
-- open new tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {
	desc = "Open new tab",
})
-- close current tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {
	desc = "Close current tab",
})
-- move to next tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {
	desc = "Go to next tab",
})
-- move to previous tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {
	desc = "Go to previous tab",
})
-- open current buffer in new tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {
	desc = "Open current buffer in new tab",
})

-- buffer management
-- switch to next buffer
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", {
	desc = "Switch to next buffer",
})
-- switch to previous buffer
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", {
	desc = "Switch to previous buffer",
})
-- close current buffer
keymap.set("n", "<leader>bd", "<cmd>bd<CR>", {
	desc = "Close current buffer",
})
-- close all buffer
keymap.set("n", "<leader>bq", ":bufdo bdelete<CR>", {
	desc = "Close all buffer",
})

-- increment/decrement of window width and height
-- make the window bigger vertically
keymap.set("n", "<C-Left>", [[<cmd>vertical resize +5<cr>]], {
	desc = "Make the window bigger vertically",
})
-- make the window smaller vertically
keymap.set("n", "<C-Right>", [[<cmd>vertical resize -5<cr>]], {
	desc = "Make the window smaller vertically",
})
-- make the window bigger horizontally
keymap.set("n", "<C-Up>", [[<cmd>horizontal resize +2<cr>]], {
	desc = "Make the window bigger horizontally",
})
-- make the window smaller horizontally
keymap.set("n", "<C-Down>", [[<cmd>horizontal resize -2<cr>]], {
	desc = "Make the window smaller horizontally",
})

-- Map to NetRW
-- keymap.set("n", "<leader>pw", vim.cmd.Ex, {
--    desc = "Open NetRW",
-- })

-- keep visual mode selection after indenting
keymap.set("v", "<", "<gv", { silent = true }, {
	desc = "Keep visual mode selection after indenting",
})
keymap.set("v", ">", ">gv", { silent = true }, {
	desc = "Keep visual mode selection after indenting",
})

-- centering navigation
keymap.set("n", "<C-d>", "<C-d>zz", {
	desc = "Centering Navigation with <C-d>",
})
keymap.set("n", "<C-u>", "<C-u>zz", {
	desc = "Centering Navigation with <C-u>",
})
keymap.set("n", "n", "nzzzv", {
	desc = "Centering Navigation with n",
})
keymap.set("n", "N", "Nzzzv", {
	desc = "Centering Navigation with N",
})

-- move selected lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
	desc = "Move selected lines down",
})
keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
	desc = "Move selected lines up",
})

-- join lines
keymap.set("n", "J", "mzJ`z", {
	desc = "Join lines and keep cursor position",
})

-- copy to system clipboard
keymap.set("v", "<leader>y", '"+y', {
	desc = "Copy to system clipboard",
})

-- paste from system clipboard
keymap.set("n", "<leader>p", '"+p', {
	desc = "Paste from system clipboard",
})

-- make the file executable
keymap.set("n", "<leader>x", ":!chmod +x %<CR>", {
	desc = "Make the file executable",
})

-- move up and down through the visual line
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
	expr = true,
	desc = "Move Up through the visual line",
})
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
	expr = true,
	desc = "Move Down through the visual line",
})
