-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {}

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
