return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local oil = require("oil")

        oil.setup({
            default_file_explorer = true,
            keymaps = {
                [".."] = "actions.toggle_hidden",
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-j>"] = false,
                ["<C-k>"] = false,
            },
            view_options = {
                show_hidden = true,
            },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>pw", "<cmd>Oil<CR>", { desc = "Open parent directory" })
    end,
}
