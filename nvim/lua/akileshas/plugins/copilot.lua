-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    panel = {
        enabled = false,
    },
    suggestion = {
        enabled = false,
    },
    filetypes = {
        yaml = true,
        markdown = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
        svn = true,
        cvs = true,
        ["."] = true,
    },
    copilot_node_command = "node",
}

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "zbirenbaum/copilot.lua",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "InsertEnter",
    },
    cmd = {
        "Copilot",
    },
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
