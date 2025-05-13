-- for convenience
local keymap = vim.keymap
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

-- join lines
keymap.set("n", "J", "mzJ`z", {
    desc = "Join lines and keep cursor position",
})

-- copy to system clipboard
keymap.set("n", "<leader>G", 'gg0"+yG<C-o>', {
    desc = "Copy the whole file to system clipboard and register",
})

-- make the file executable
keymap.set("n", "<leader>x", ":!chmod +x %<CR>", {
    desc = "Make the file executable",
})

-- go to the file under the cursor
keymap.set("", "gf", ":tabedit <cfile><CR>", {
    desc = "Go to the file under the cursor",
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
