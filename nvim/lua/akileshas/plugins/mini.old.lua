-- plugin dependencies
local dependencies = {
    ui = {
        statusline = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
}

-- plugin init function
local init = {
    ui = {
        statusline = function () end,
    },
}

-- plugin opts
local opts = {
    ui = {
        statusline = {
            use_icons = true,
        },
    },
}

-- plugin keys
local keys = {
    ui = {
        statusline = {},
    },
}

-- plugin configurations
return {
    "echasnovski/mini.statusline",
    version = "*",
    enabled = true,
    lazy = false,
    priority = 100,
    event = {},
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies.ui.statusline,
    init = init.ui.statusline,
    opts = opts.ui.statusline,
    keys = keys.ui.statusline,
}
