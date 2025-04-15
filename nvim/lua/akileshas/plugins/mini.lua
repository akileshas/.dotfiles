-- plugin dependencies
local dependencies = {
    ai = {},
}

-- plugin init function
local init = {
    ai = function() end
}

-- plugin opts
local opts = {
    ai = {
        mappings = {
            around = "a",
            inside = "i",
            around_next = "an",
            inside_next = "in",
            around_last = "ap",
            inside_last = "ip",
            goto_left = "g[",
            goto_right = "g]",
        },
        n_lines = 1000000000,
        search_method = "cover_or_next",
    },
}

-- plugin keys
local keys = {
    ai = {},
}

-- plugin configurations
return {
    {
        "echasnovski/mini.ai",
        version = "*",
        enabled = true,
        lazy = true,
        event = {
            "VeryLazy",
        },
        cmd = {},
        ft = {},
        build = {},
        dependencies = dependencies.ai,
        init = init.ai,
        opts = opts.ai,
        keys = keys.ai,
    },
}
