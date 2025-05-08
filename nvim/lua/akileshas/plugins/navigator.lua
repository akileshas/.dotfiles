-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    auto_save = nil,
    disable_on_zoom = true,
    mux = "auto",
}

-- plugin keys
local keys = {
    {
        "<C-h>",
        mode = { "" },
        function ()
            -- for convenience
            local navigator = require("Navigator")

            navigator.left()
        end,
        noremap = true,
        silent = true,
        desc = "move to the left mux pane",
    },
    {
        "<C-l>",
        mode = { "" },
        function ()
            -- for convenience
            local navigator = require("Navigator")

            navigator.right()
        end,
        noremap = true,
        silent = true,
        desc = "move to the right mux pane",
    },
    {
        "<C-j>",
        mode = { "" },
        function ()
            -- for convenience
            local navigator = require("Navigator")

            navigator.down()
        end,
        noremap = true,
        silent = true,
        desc = "move to the down mux pane",
    },
    {
        "<C-k>",
        mode = { "" },
        function ()
            -- for convenience
            local navigator = require("Navigator")

            navigator.up()
        end,
        noremap = true,
        silent = true,
        desc = "move to the up mux pane",
    },
    {
        "<C-\\>",
        mode = { "" },
        function ()
            -- for convenience
            local navigator = require("Navigator")

            navigator.previous()
        end,
        noremap = true,
        silent = true,
        desc = "move to the previous mux pane",
    },
}

-- plugin configurations
return {
    "numToStr/Navigator.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
