-- plugin dependencies
local dependencies = {
    edit = {
        ai = {},
    },
}

-- plugin init function
local init = {
    edit = {
        ai = function() end,
    },
}

-- plugin opts
local opts = {
    edit = {
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
    },
}

-- plugin keys
local keys = {
    edit = {
        ai = {},
    },
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
        dependencies = dependencies.edit.ai,
        init = init.edit.ai,
        opts = opts.edit.ai,
        keys = keys.edit.ai,
    },
}
