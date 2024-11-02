
return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- load during startup
    priority = 1000, -- load before other plugins
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            term_colors = true,
        })

        -- Set the colorscheme
        vim.cmd.colorscheme("catppuccin")
    end,
}
