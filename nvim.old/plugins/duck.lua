-- plugin options
local options = {}

-- plugin keymaps
local keymaps = {
    {
        "<leader>dh",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").hatch("🐤")
        end,
        noremap = true,
        silent = true,
        desc = "hatch a hen",
    },
    {
        "<leader>dd",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").hatch("🦆")
        end,
        noremap = true,
        silent = true,
        desc = "hatch a duck",
    },
    {
        "<leader>dc",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").hatch("🐈")
        end,
        noremap = true,
        silent = true,
        desc = "hatch a cat",
    },
    {
        "<leader>dr",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").hatch("🦀")
        end,
        noremap = true,
        silent = true,
        desc = "hatch a rust",
    },
    {
        "<leader>dk",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").cook()
        end,
        noremap = true,
        silent = true,
        desc = "cook one of them",
    },
    {
        "<leader>da",
        mode = "n",
        function()
            require("nvim.old.plugins.duck").cook_all()
        end,
        noremap = true,
        silent = true,
        desc = "cook all",
    },
}

-- plugin configurations
return {
    "tamton-aquib/duck.nvim",
    lazy = true,
    opts = options,
    keys = keymaps,
}
