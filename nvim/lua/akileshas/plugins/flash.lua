-- for convenience
local api = vim.api
local diagnostic = vim.diagnostic
local fn = vim.fn

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    modes = {
        char = {
            jump_labels = true,
            keys = { "f", "F", "t", "T" },
        },
    },
}

-- plugin keys
local keys = {
    {
        ",fs",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump()
        end,
        noremap = true,
        silent = true,
        desc = "flash jump",
    },
    {
        ",fS",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.treesitter_search()
        end,
        noremap = true,
        silent = true,
        desc = "flash treesitter search",
    },
    {
        ",ft",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.treesitter()
        end,
        noremap = true,
        silent = true,
        desc = "flash treesitter",
    },
    {
        ",fw",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump({
                pattern = fn.expand("<cword>"),
            })
        end,
        noremap = true,
        silent = true,
        desc = "flash jump word under cursor",
    },
    {
        ",fl",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump({
                search = {
                    mode = "search",
                    max_length = 0,
                },
                label = {
                    after = { 0, 0 },
                },
                pattern = "^",
            })
        end,
        noremap = true,
        silent = true,
        desc = "flash jump line",
    },
    {
        ",fd",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump({
                action = function (match, state)
                    api.nvim_win_call(match.win, function ()
                        api.nvim_win_set_cursor(match.win, match.pos)
                        diagnostic.open_float({
                            border = "rounded",
                        })
                    end)
                    state:restore()
                end,
            })
        end,
        noremap = true,
        silent = true,
        desc = "flash jump to diagnostics",
    },
    {
        ",fr",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump({
                continue = true,
            })
        end,
        noremap = true,
        silent = true,
        desc = "flash resume",
    },
    {
        "r",
        mode = { "o" },
        function ()
            local flash = require("flash")

            flash.remote()
        end,
        noremap = true,
        silent = true,
        desc = "flash remote",
    },
    {
        "<C-z>",
        mode = { "c" },
        function ()
            local flash = require("flash")

            flash.toggle()
        end,
        noremap = true,
        silent = true,
        desc = "toggle flash search",
    },
}

-- plugin configurations
return {
    "folke/flash.nvim",
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
