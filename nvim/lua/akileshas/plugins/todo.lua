-- for convenience
local cmd = vim.cmd

-- plugin dependencies
local dependencies = {
    {
        "nvim-lua/plenary.nvim",
    },
}

-- plugin init function
local init = function () end

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
        function ()
            cmd("TodoQuickFix")
        end,
        noremap = true,
        silent = true,
        desc = "search for todo comments",
    },
    {
        "]t",
        mode = { "n" },
        function ()
            -- for convenience
            local todo_comments = require("todo-comments")

            todo_comments.jump_next()
        end,
        noremap = true,
        silent = true,
        desc = "jump to next todo comment",
    },
    {
        "[t",
        mode = { "n" },
        function ()
            -- for convenience
            local todo_comments = require("todo-comments")

            todo_comments.jump_prev()
        end,
        noremap = true,
        silent = true,
        desc = "jump to previous todo comment",
    },
}

-- plugin configurations
return {
    "folke/todo-comments.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "BufReadPost",
        "BufNewFile",
        "BufWritePre",
    },
    cmd = {
        "TodoTrouble",
        "TodoQuickFix",
    },
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
