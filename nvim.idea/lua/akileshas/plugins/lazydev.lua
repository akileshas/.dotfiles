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
            path = "snacks.nvim",
            words = { "Snacks" }
        },
        {
            path = "lazy.nvim",
            words = { "vim", "lazy" }
        },
        {
            path = "mini.ai",
            words = { "MiniAi" },
        },
        {
            path = "mini.comment",
            words = { "MiniComment" },
        },
        {
            path = "mini.move",
            words = { "MiniMove" },
        },
        {
            path = "mini.operators",
            words = { "MiniOperators" },
        },
        {
            path = "mini.pairs",
            words = { "MiniPairs" },
        },
        {
            path = "mini.splitjoin",
            words = { "MiniSplitjoin" },
        },
        {
            path = "mini.surround",
            words = { "MiniSurround" },
        },
        {
            path = "mini.trailspace",
            words = { "MiniTrailspace" },
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
