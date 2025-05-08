-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    library = {
        {
            path = "${3rd}/luv/library",
            words = { "vim%.uv" }
        },
        {
            path = "LazyVim",
            words = { "LazyVim" }
        },
        {
            path = "snacks.nvim",
            words = { "Snacks" }
        },
        {
            path = "lazy.nvim",
            words = { "LazyVim" }
        },
    },
}

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "folke/lazydev.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {
        "LazyDev",
    },
    ft = {
        "lua",
    },
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
