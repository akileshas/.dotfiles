-- for convenience
local keymap = vim.keymap

keymap.set({ "n" }, "<localleader>fo", "zo", {
    noremap = true,
    silent = true,
    desc = "open the folds",
})

keymap.set({ "n" }, "<localleader>fc", "zc", {
    noremap = true,
    silent = true,
    desc = "close the folds",
})

keymap.set({ "n" }, "<localleader>fO", "zR", {
    noremap = true,
    silent = true,
    desc = "open all folds",
})

keymap.set({ "n" }, "<localleader>fC", "zM", {
    noremap = true,
    silent = true,
    desc = "close all folds",
})

keymap.set({ "n" }, "<leader>cl", "<cmd>Lazy<CR>", {
    noremap = true,
    silent = true,
    desc = "open lazy.nvim",
})

keymap.set({ "i" }, "jj", "<ESC>", {
    noremap = true,
    silent = true,
    desc = "exit insert mode with jj",
})

keymap.set({ "t" }, "<C-e>", "<C-\\><C-n>", {
    noremap = true,
    silent = true,
    desc = "exit terminal mode",
})

keymap.set({ "n", "x" }, "<leader>cs", "<cmd>nohlsearch<CR>", {
    noremap = true,
    silent = true,
    desc = "clear search highlights",
})

keymap.set({ "n", "x" }, "=", "<C-a>", {
    noremap = true,
    silent = true,
    desc = "increment number",
})

keymap.set({ "n", "x" }, "-", "<C-x>", {
    noremap = true,
    silent = true,
    desc = "decrement number",
})

keymap.set({ "n", "x" }, "<C-w>\\", "<C-w>v", {
    noremap = true,
    silent = true,
    desc = "split window vertically",
})

keymap.set({ "n", "x" }, "<C-w>-", "<C-w>s", {
    noremap = true,
    silent = true,
    desc = "split window horizontally",
})

keymap.set({ "n", "x" }, "<C-w>=", "<C-w>=", {
    noremap = true,
    silent = true,
    desc = "make splits equal size",
})

keymap.set({ "n", "x" }, "<C-up>", "<cmd>horizontal resize +2<CR>", {
    noremap = true,
    silent = true,
    desc = "increase the window height",
})

keymap.set({ "n", "x" }, "<C-down>", "<cmd>horizontal resize -2<CR>", {
    noremap = true,
    silent = true,
    desc = "decrease the window height",
})

keymap.set({ "n", "x" }, "<C-left>", "<cmd>vertical resize -2<CR>", {
    noremap = true,
    silent = true,
    desc = "decrease the window width",
})

keymap.set({ "n", "x" }, "<C-right>", "<cmd>vertical resize +2<CR>", {
    noremap = true,
    silent = true,
    desc = "increase the window width",
})

keymap.set({ "x" }, "<", "<gv", {
    noremap = true,
    silent = true,
    desc = "keep visual mode selection after indenting",
})

keymap.set({ "x" }, ">", ">gv", {
    noremap = true,
    silent = true,
    desc = "keep visual mode selection after indenting",
})

keymap.set({ "n", "x" }, "x", [["_x]], {
    noremap = true,
    silent = true,
    desc = "do not copy on x",
})

keymap.set({ "x" }, "p", [["_dP]], {
    noremap = true,
    silent = true,
    desc = "do not copy on paste",
})

keymap.set({ "n", "x" }, "<leader>d", [["_d]], {
    noremap = true,
    silent = true,
    desc = "do not copy on delete",
})

keymap.set({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], {
    noremap = true,
    silent = true,
    expr = true,
    desc = "move down through the visual line",
})

keymap.set({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], {
    noremap = true,
    silent = true,
    expr = true,
    desc = "move up through the visual line",
})

keymap.set({ "n", "x" }, "<leader>ww", "<cmd>set wrap!<CR>", {
    noremap = true,
    silent = true,
    desc = "toggle word wrap",
})

keymap.set({ "i", "c" }, "<C-n>", "<NOP>", {
    noremap = true,
    silent = true,
    desc = "hide omni completion",
})

keymap.set({ "i", "c" }, "<C-p>", "<NOP>", {
    noremap = true,
    silent = true,
    desc = "hide omni completion",
})

keymap.set({ "c" }, "<Tab>", "<NOP>", {
    noremap = true,
    silent = true,
    desc = "hide omni completion",
})

keymap.set({ "c" }, "<S-Tab>", "<NOP>", {
    noremap = true,
    silent = true,
    desc = "hide omni completion",
})

keymap.set({ "c" }, "<C-d>", "<NOP>", {
    noremap = true,
    silent = true,
    desc = "hide omni completion",
})

keymap.set({ "i" }, "<C-x>", "<NOP>", {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "hide omni completion",
})

keymap.set({ "i", "s" }, "<Tab>", "<Tab>", {
    noremap = true,
    silent = true,
    desc = "overwrite the jump to next snippet",
})

keymap.set({ "i", "s" }, "<S-Tab>", "<S-Tab>", {
    noremap = true,
    silent = true,
    desc = "overwrite the jump to previous snippet",
})

return {}
