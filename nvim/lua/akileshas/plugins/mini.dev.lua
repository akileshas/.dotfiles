-- plugin dependencies
local dependencies = {
    edit = {
        comment = {},
        move = {},
    },
}

-- plugin init function
local init = {
    edit = {
        comment = function () end,
        move = function () end,
    },
}

-- plugin opts
local opts = {
    edit = {
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
}

-- plugin keys
local keys = {
    edit = {
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
}

-- plugin configurations
return {
    -- text editing
    {
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
