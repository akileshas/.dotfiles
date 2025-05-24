-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    skip_filetypes = {},
    enabled = true,
    allow_scroll_move = true,
    disable_on_mouse = true,
}

-- plugin keys
local keys = {
    {
        "<leader>tc",
        mode = { "n", "x" },
        function ()
            -- for convernience
            local stay_centered = require("stay-centered")

            stay_centered.toggle()
        end,
        noremap = true,
        silent = true,
        desc = "toggle stay-centered.nvim",
    },
}

-- plugin configurations
return {
    "arnamak/stay-centered.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "VeryLazy",
    },
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
