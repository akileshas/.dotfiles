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
    search = {
        multi_window = true,
        forward = true,
        wrap = true,
        mode = "search",
        incremental = false,
        max_length = false,
    },
    jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
    },
    label = {
        uppercase = true,
        current = true,
        after = false,
        before = true,
        style = "inline",
        reuse = "lowercase",
        distance = true,
        min_pattern_length = 0,
        rainbow = {
            enabled = false,
            shade = 5,
        },
    },
    highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
    },
    continue = false,
    modes = {
        search = {
            enabled = false,
            highlight = {
                backdrop = false,
                matches = true,
            },
            jump = {
                jumplist = true,
                pos = "start",
                history = true,
                register = true,
                nohlsearch = false,
                autojump = false,
            },
        },
        char = {
            enabled = true,
            autohide = false,
            jump_labels = true,
            multi_line = true,
            keys = { "f", "F", "t", "T" },
            search = {
                wrap = false,
            },
            highlight = {
                backdrop = true,
                matches = true,
            },
            jump = {
                jumplist = true,
                pos = "start",
                history = false,
                register = false,
                nohlsearch = false,
                autojump = false,
            },
        },
        treesitter = {
            jump = {
                jumplist = true,
                pos = "range",
                history = false,
                register = false,
                nohlsearch = false,
                autojump = false,
            },
            search = {
                incremental = false,
            },
            label = {
                after = true,
                before = true,
                style = "inline",
            },
            highlight = {
                backdrop = false,
                matches = false,
            },
        },
        treesitter_search = {
            jump = {
                jumplist = true,
                pos = "range",
                history = false,
                register = false,
                nohlsearch = false,
                autojump = false,
            },
            search = {
                multi_window = true,
                wrap = true,
                incremental = false,
            },
            remote_op = {
                restore = true,
                motion = false,
            },
            label = {
                after = true,
                before = true,
                style = "inline",
            },
        },
        remote = {
            remote_op = {
                restore = true,
                motion = true,
            },
        },
    },
    prompt = {
        enabled = true,
    },
    remote_op = {
        restore = false,
        motion = false,
    },
}

-- plugin keys
local keys = {
    {
        ",fa",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            local format = function (opts)
                return {
                    {
                        opts.match.label1,
                        "FlashMatch",
                    },
                    {
                        opts.match.label2,
                        "FlashLabel",
                    },
                }
            end

            flash.jump({
                search = {
                    mode = "search",
                },
                label = {
                    uppercase = false,
                    after = false,
                    before = { 0, 0 },
                    style = "overlay",
                    format = format,
                },
                pattern = [[\<]],
                action = function (match, state)
                    state:hide()
                    flash.jump({
                        search = {
                            max_length = 0,
                        },
                        highlight = {
                            matches = false,
                        },
                        label = {
                            format = format,
                        },
                        matcher = function (win)
                            return vim.tbl_filter(function (m)
                                return m.label == match.label and m.win == win
                            end, state.results)
                        end,
                        labeler = function (matches)
                            for _, m in ipairs(matches) do
                                m.label = m.label2
                            end
                        end,
                    })
                end,
                labeler = function (matches, state)
                    local labels = state:labels()

                    for m, match in ipairs(matches) do
                        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                        match.label2 = labels[(m - 1) % #labels + 1]
                        match.label = match.label1
                    end
                end,
            })
        end,
        noremap = true,
        silent = true,
        desc = "flash all",
    },
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
