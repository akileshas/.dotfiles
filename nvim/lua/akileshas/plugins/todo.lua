-- for convenience
local cmd = vim.cmd

-- plugin dependencies
local dependencies = {
    {
        "nvim-lua/plenary.nvim",
    },
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
    signs = true,
    sign_priority = 8,
    merge_keywords = true,
    highlight = {
        multiline = true,
    },
}

-- plugin keys
local keys = {
    {
        "<leader>st",
        mode = { "n" },
        function()
            cmd("TodoQuickFix")
        end,
        noremap = true,
        silent = true,
        desc = "search for todo comments",
    },
}

-- plugin configurations
return {
    "folke/todo-comments.nvim",
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
