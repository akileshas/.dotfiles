-- plugin dependencies
local dependencies = {
    edit = {
        ai = {},
    },
    flow = {},
    ui = {},
    etc = {},
}

-- plugin init function
local init = {
    edit = {
        ai = function () end,
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
    },

    -- general workflow
    {},

    -- appearance
    {},

    -- other
    {},
}
