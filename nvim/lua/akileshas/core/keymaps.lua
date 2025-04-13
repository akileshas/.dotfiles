-- for convenience
local keymap = vim.keymap

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

keymap.set({ "n", "v", "x" }, "<leader>cl", "<cmd>nohlsearch<CR>", {
    noremap = true,
    silent = true,
    desc = "clear search highlights",
})

keymap.set({ "n", "v", "x" }, "=", "<C-a>", {
    noremap = true,
    silent = true,
    desc = "increment number",
})

keymap.set({ "n", "v", "x" }, "-", "<C-x>", {
    noremap = true,
    silent = true,
    desc = "decrement number",
})

keymap.set({ "n", "v", "x" }, "<leader>sv", "<C-w>v", {
    noremap = true,
    silent = true,
    desc = "split window vertically",
})

keymap.set({ "n", "v", "x" }, "<leader>sh", "<C-w>s", {
    noremap = true,
    silent = true,
    desc = "split window horizontally",
})

keymap.set({ "n", "v", "x" }, "<leader>se", "<C-w>=", {
    noremap = true,
    silent = true,
    desc = "make splits equal size",
})

keymap.set({ "n", "v", "x" }, "<leader>sx", "<cmd>close<CR>", {
    noremap = true,
    silent = true,
    desc = "close current split",
})

keymap.set({ "n", "v", "x" }, "<C-left>", "<cmd>vertical resize -5<CR>", {
    noremap = true,
    silent = true,
    desc = "make the window bigger vertically",
})

keymap.set({ "n", "v", "x" }, "<C-right>", "<cmd>vertical resize +5<CR>", {
    noremap = true,
    silent = true,
    desc = "make the window smaller vertically",
})

keymap.set({ "n", "v", "x" }, "<C-down>", "<cmd>horizontal resize -2<CR>", {
    noremap = true,
    silent = true,
    desc = "make the window smaller horizontally",
})

keymap.set({ "n", "v", "x" }, "<C-up>", "<cmd>horizontal resize +2<CR>", {
    noremap = true,
    silent = true,
    desc = "make the window bigger horizontally",
})

keymap.set({ "v", "x" }, "<", "<gv", {
    noremap = true,
    silent = true,
    desc = "keep visual mode selection after indenting",
})

keymap.set({ "v", "x" }, ">", ">gv", {
    noremap = true,
    silent = true,
    desc = "keep visual mode selection after indenting",
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

keymap.set({ "n", "v", "x" }, "<leader>d", [["_d]], {
    noremap = true,
    silent = true,
    desc = "do not copy on delete",
})

keymap.set({ "n", "v", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], {
    noremap = true,
    silent = true,
    expr = true,
    desc = "move down through the visual line",
})

keymap.set({ "n", "v", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], {
    noremap = true,
    silent = true,
    expr = true,
    desc = "move up through the visual line",
})

return {}
