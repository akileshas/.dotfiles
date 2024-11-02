return {
    "mbbill/undotree",
    config = function()
        local keymap = vim.keymap
        keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle undotree" })
    end,
}
