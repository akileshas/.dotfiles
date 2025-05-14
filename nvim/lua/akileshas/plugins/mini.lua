-- plugin dependencies
local dependencies = {
    edit = {
        ai = {},
        comment = {},
        move = {},
    },
    flow = {},
    ui = {},
    etc = {},
}

-- plugin init function
local init = {
    edit = {
        ai = function () end,
        comment = function () end,
        move = function () end,
    },
    flow = {},
    ui = {},
    etc = {},
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
                around_last = "al",
                inside_last = "il",
                goto_left = "g[",
                goto_right = "g]",
            },
            n_lines = 1000,
            search_method = "cover_or_next",
            silent = false,
        },
        comment = {
            options = {
                custom_commentstring = nil,
                ignore_blank_line = false,
                start_of_line = false,
                pad_comment_parts = true,
            },
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc",
            },
            hooks = {
                pre = function () end,
                post = function () end,
            },
        },
        move = {
            mappings = {
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
            },
            options = {
                reindent_linewise = true,
            },
        },
    },
    flow = {},
    ui = {},
    etc = {},
}

-- plugin config function
local config = {
    edit = {
        ai = function (_, opts)
            local MiniAi = require("mini.ai")
            local mini_utils = require("akileshas.utils.mini")

            opts.custom_textobjects = {
                o = MiniAi.gen_spec.treesitter({
                    a = {
                        "@block.outer",
                        "@conditional.outer",
                        "@loop.outer",
                    },
                    i = {
                        "@block.inner",
                        "@conditional.inner",
                        "@loop.inner",
                    },
                }),
                f = MiniAi.gen_spec.treesitter({
                    a = { "@function.outer" },
                    i = { "@function.inner" },
                }),
                c = MiniAi.gen_spec.treesitter({
                    a = { "@class.outer" },
                    i = { "@class.inner" },
                }),
                t = {
                    { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>" },
                    { "^<.->().*()</[^/]->$" },
                },
                w = {
                    { "%f[%w]%w+" },
                    { "^().*()$" },
                },
                W = {
                    { "%f[%S]%S+" },
                    { "^().*()$" },
                },
                d = {
                    { "%f[%d]%d+" },
                },
                g = mini_utils.ai_buffer,
                u = MiniAi.gen_spec.function_call(),
                U = MiniAi.gen_spec.function_call({
                    name_pattern = "[%w_]",
                }),
            }

            MiniAi.setup(opts)
        end,
    },
    flow = {},
    ui = {},
    etc = {},
}

-- plugin keys
local keys = {
    edit = {
        ai = {},
        comment = {},
        move = {
            {
                "<M-h>",
                mode = { "i" },
                function ()
                    MiniMove.move_line("left")
                end,
                noremap = true,
                silent = true,
                desc = "move line left",
            },
            {
                "<M-l>",
                mode = { "i" },
                function ()
                    MiniMove.move_line("right")
                end,
                noremap = true,
                silent = true,
                desc = "move line right",
            },
            {
                "<M-j>",
                mode = { "i" },
                function ()
                    MiniMove.move_line("down")
                end,
                noremap = true,
                silent = true,
                desc = "move line down",
            },
            {
                "<M-k>",
                mode = { "i" },
                function ()
                    MiniMove.move_line("up")
                end,
                noremap = true,
                silent = true,
                desc = "move line up",
            },
        },
    },
    flow = {},
    ui = {},
    etc = {},
}

-- plugin configurations
return {
    -- text editing
    {
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
            init  = init.edit.ai,
            opts = opts.edit.ai,
            config = config.edit.ai,
            keys = keys.edit.ai,
        },
        {
            "echasnovski/mini.comment",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.comment,
            init = init.edit.comment,
            opts = opts.edit.comment,
            keys = keys.edit.comment,
        },
        {
            "echasnovski/mini.move",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.move,
            init = init.edit.move,
            opts = opts.edit.move,
            keys = keys.edit.move,
        },
    },

    -- general workflow
    {},

    -- appearance
    {},

    -- other
    {},
}
