-- for convenience
local keymap = vim.keymap
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local lsp = vim.lsp

-- Importing the functions from functions.lua
local functions = require("akileshas.core.functions")

-- Source the current file
keymap.set("n", "<leader>so", ":source %<CR>", {
	desc = "Source the current file",
})

-- format the whole file using the lsp's default formatter
keymap.set("n", "<leader>mP", lsp.buf.format, {
	desc = "Format the whole file",
})

-- delete single character without copying into register
keymap.set("n", "X", '"_x', {
	desc = "Delete single character without copying",
})

-- delete without copying into register
keymap.set("n", "<leader>d", [["_d]], {
	desc = "Delete without copying",
})
keymap.set("v", "<leader>d", [["_d]], {
	desc = "Delete without copying",
})

-- tab management
-- open new tab
keymap.set("n", "<A-t>", "<cmd>tabnew<CR>", {
	desc = "Open new tab",
})
-- open new tab with current buffer
keymap.set("n", "<A-y>", "<cmd>tabnew %<CR>", {
	desc = "Open new tab with current buffer",
})
-- close current tab
keymap.set("n", "<A-w>", "<cmd>tabclose<CR>", {
	desc = "Close current tab",
})
-- close all tabs except current tab
keymap.set("n", "<A-q>", "<cmd>tabonly<CR>", {
	desc = "Close all tabs except current tab",
})
-- move to next tab
keymap.set("n", "<A-.>", "<cmd>tabn<CR>", {
	desc = "Go to next tab",
})
-- move to previous tab
keymap.set("n", "<A-,>", "<cmd>tabp<CR>", {
	desc = "Go to previous tab",
})
keymap.set("n", "<A-]>", "<cmd>tabmove +1<CR>", {
	desc = "Move current tab to the right",
})
keymap.set("n", "<A-[>", "<cmd>tabmove -1<CR>", {
	desc = "Move current tab to the left",
})
-- move to specific tab
for i = 1, 9 do
	keymap.set("n", "<A-" .. i .. ">", "<cmd>tabnext " .. i .. "<CR>", {
		desc = "Go to tab " .. i,
	})
end
-- move to last tab
keymap.set("n", "<A-0>", "<cmd>tablast<CR>", {
	desc = "Go to last tab",
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

-- Map to NetRW
-- keymap.set("n", "<leader>pw", cmd.Ex, {
--    desc = "Open NetRW",
-- })

-- move selected lines
keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi", {
	desc = "Move selected line down",
})
keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi", {
	desc = "Move selected line up",
})
keymap.set("n", "<A-j>", ":move .+1<CR>==", {
	desc = "Move current line down",
})
keymap.set("n", "<A-k>", ":move .-2<CR>==", {
	desc = "Move current line up",
})
keymap.set("v", "<A-j>", ":move '>+1<CR>gv-gv", {
	desc = "Move selected lines down",
})
keymap.set("v", "<A-k>", ":move '<-2<CR>gv-gv", {
	desc = "Move selected lines up",
})

-- join lines
keymap.set("n", "J", "mzJ`z", {
	desc = "Join lines and keep cursor position",
})

-- copy to system clipboard
keymap.set("n", "<leader>y", '"+y', {
	desc = "Copy to system clipboard",
})
keymap.set("v", "<leader>y", '"+y', {
	desc = "Copy to system clipboard",
})
keymap.set("v", "<leader>Y", '"+y', {
	desc = "Copy to system clipboard",
})
keymap.set("n", "<leader>Y", '"+yg_', {
	desc = "Copy till the end of the line",
})
keymap.set("n", "<leader>G", 'gg0"+yG<C-o>', {
	desc = "Copy the whole file to system clipboard and register",
})

-- paste from system clipboard
keymap.set("n", "<leader>p", '"+p', {
	desc = "Paste from system clipboard",
})
keymap.set("v", "<leader>p", '"_d"+p', {
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

-- go to the file under the cursor
keymap.set("", "gf", ":tabedit <cfile><CR>", {
	desc = "Go to the file under the cursor",
})

-- change the default behaviour of the p command
keymap.set("v", "p", '"_dP', {
	desc = "Doen't copy the text after pasting",
})

-- insert ; and , at the end of the line
keymap.set("i", ";;", "<Esc>A;<Esc>", {
	desc = "Insert ; at the end of the line",
})
keymap.set("n", ";;", "<Esc>A;<Esc>", {
	desc = "Insert ; at the end of the line",
})
keymap.set("i", ",,", "<Esc>A,<Esc>", {
	desc = "Insert , at the end of the line",
})
keymap.set("n", ",,", "<Esc>A,<Esc>", {
	desc = "Insert , at the end of the line",
})

-- cellular automaton keymaps
keymap.set({ "n", "v" }, "<leader>fr", "<cmd>CellularAutomaton make_it_rain<CR>", {
	desc = "Make it rain",
})
keymap.set({ "n", "v" }, "<leader>fs", "<cmd>CellularAutomaton scramble<CR>", {
	desc = "Scramble",
})
keymap.set({ "n", "v" }, "<leader>fl", "<cmd>CellularAutomaton game_of_life<CR>", {
	desc = "Game of life",
})

-- open the terminal in new tab and go to insert mode
keymap.set("n", "<leader>;", ":tab terminal<CR>i", {
	desc = "Open the terminal in new tab and go to insert mode",
})

-- open the command line window
keymap.set("n", "<leader>:", functions.toggle_command_line, {
	desc = "Toggle the command-line window",
})

-- open the file the default program
keymap.set("n", "<leader>o", functions.open_file_default_program, {
	desc = "Open image or PDF with default program",
})

-- copy the whole file to system clipboard
keymap.set(
	"n",
	"<leader>g",
	functions.copy_whole_file_to_system_clipboard,
	{ desc = "Copy the whole file to system clipboard" }
)

-- run the python script
keymap.set("n", "<leader>pr", functions.run_python_script, {
	desc = "Run the Python script",
})

-- run the c/c++ script
keymap.set("n", "<leader>cr", functions.run_c_cpp_script, {
	desc = "Run the C/C++ script",
})
