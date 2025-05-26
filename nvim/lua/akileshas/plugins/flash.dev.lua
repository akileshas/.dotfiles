-- for convenience
local api = vim.api
local bo = vim.bo
local diagnostic = vim.diagnostic
local fn = vim.fn

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    modes = {
        treesitter = {
            jump = {
                autojump = false,
            },
        },
    },
}

-- plugin keys
local keys = {
    {
        ",fa",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            local format1 = function (opts)
                return {
                    {
                        opts.match.label1,
                        "FlashLabel",
                    },
                }
            end

            local format2 = function (opts)
                return {
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
                    before = true,
                    style = "inline",
                    format = format1,
                },
                highlight = {
                    matches = false,
                },
                prompt = {
                    enabled = false,
                },
                pattern = [[\<\|\>]],
                action = function (match, state)
                    state:hide()
                    flash.jump({
                        search = {
                            max_length = 0,
                        },
                        label = {
                            uppercase = false,
                            after = false,
                            before = true,
                            style = "inline",
                            format = format2,
                        },
                        highlight = {
                            matches = false,
                        },
                        prompt = {
                            enabled = false,
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
        desc = "flash jump 2d",
    },
    {
        ",fs",
        mode = { "n", "x", "o" },
        function ()
            local flash = require("flash")

            flash.jump({
                search = {
                    mode = "search",
                },
                label = {
                    after = false,
                    before = true,
                    style = "inline",
                },
            })
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
                label = {
                    after = false,
                    before = true,
                    style = "inline",
                },
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
                    after = false,
                    before = true,
                    style = "inline",
                },
                highlight = {
                    matches = false,
                    groups = {
                        current = "FlashLabel",
                    },
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
}

-- plugin specs
local specs = {}

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
    specs = specs,
}
