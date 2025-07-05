-- for convenience
local api = vim.api
local bo = vim.bo
local diagnostic = vim.diagnostic
local fn = vim.fn
local v = vim.v

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    modes = {
        search = {
            search = {
                trigger = ",",
            },
            label = {
                after = false,
                before = true,
                style = "inline",
            },
        },
        char = {
            jump_labels = true,
            label = {
                after = false,
                before = true,
                style = "inline",
            },
            keys = { "f", "F", "t", "T" },
            config = function (opts)
                opts.autohide = opts.autohide
                    or (fn.mode(true):find("no")
                        and v.operator == "y")

                opts.jump_labels = opts.jump_labels
                    and fn.reg_executing() == ""
                    and fn.reg_recording() == ""
            end,
        },
        treesitter = {
            jump = {
                autojump = false,
            },
            prompt = {
                enabled = false,
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
                    max_length = 0,
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
                pattern = [[\<\|\>]],
                prompt = {
                    enabled = false,
                },
                action = function (match, state)
                    state:hide()
                    flash.jump({
                        search = {
                            mode = "search",
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
                    trigger = ",",
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
                prompt = {
                    enabled = false,
                },
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

            -- TODO: want to update accordingly my need!!!
            flash.jump({
                search = {
                    mode = "search",
                },
                label = {
                    after = false,
                    before = true,
                    style = "inline",
                },
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

-- plugin specs
local specs = {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                win = {
                    input = {
                        keys = {
                            ["<M-j>"] = {
                                "flash",
                                mode = { "n", "i" },
                                desc = "flash jump",
                            },
                        },
                    },
                },
                actions = {
                    flash = function (picker)
                        local flash = require("flash")

                        flash.jump({
                            search = {
                                mode = "search",
                                exclude = {
                                    function (win)
                                        return bo[api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                                    end,
                                },
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
                            prompt = {
                                enabled = false,
                            },
                            action = function (match)
                                local idx = picker.list:row2idx(match.pos[1])

                                picker.list:_move(idx, true, true)
                            end,
                        })
                    end,
                },
            },
        },
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
    specs = specs,
}
