-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local opt = vim.opt
local opt_local = vim.opt_local
local ui = vim.ui
local wo = vim.wo

-- plugin dependencies
local dependencies = {
    edit = {
        ai = {},
        comment = {},
        move = {},
        operators = {},
        pairs = {},
        splitjoin = {},
        surround = {},
    },
    flow = {
        bracketed = {},
        git = {},
    },
    ui = {
        statusline = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
        trailspace = {},
    },
    etc = {},
}

-- plugin init function
local init = {
    edit = {
        ai = function () end,
        comment = function () end,
        move = function () end,
        operators = function () end,
        pairs = function () end,
        splitjoin = function () end,
        surround = function () end,
    },
    flow = {
        bracketed = function () end,
        git = function () end,
    },
    ui = {
        statusline = function () end,
        trailspace = function () end,
    },
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
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "gc",
            },
            options = {
                custom_commentstring = nil,
                ignore_blank_line = false,
                start_of_line = false,
                pad_comment_parts = true,
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
        operators = {
            evaluate = {
                prefix = ",o=",
                func = nil,
            },
            exchange = {
                prefix = ",ox",
                reindent_linewise = true,
            },
            multiply = {
                prefix = ",om",
                func = nil,
            },
            replace = {
                prefix = ",or",
                reindent_linewise = true,
            },
            sort = {
                prefix = ",os",
                func = nil,
            },
        },
        pairs = {
            mappings = {
                ["("] = {
                    action = "open",
                    pair = "()",
                    neigh_pattern = "[^\\].",
                },
                ["["] = {
                    action = "open",
                    pair = "[]",
                    neigh_pattern = "[^\\].",
                },
                ["{"] = {
                    action = "open",
                    pair = "{}",
                    neigh_pattern = "[^\\].",
                },
                [")"] = {
                    action = "close",
                    pair = "()",
                    neigh_pattern = "[^\\].",
                },
                ["]"] = {
                    action = "close",
                    pair = "[]",
                    neigh_pattern = "[^\\].",
                },
                ["}"] = {
                    action = "close",
                    pair = "{}",
                    neigh_pattern = "[^\\].",
                },
                ['"'] = {
                    action = "closeopen",
                    pair = '""',
                    neigh_pattern = "[^\\].",
                    register = { cr = false },
                },
                ["'"] = {
                    action = "closeopen",
                    pair = "''",
                    neigh_pattern = "[^%a\\].",
                    register = { cr = false },
                },
                ["`"] = {
                    action = "closeopen",
                    pair = "``",
                    neigh_pattern = "[^\\].",
                    register = { cr = false },
                },
            },
            modes = {
                insert = true,
                command = true,
                terminal = false,
            },
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            skip_ts = { "string" },
            markdown = true,
            python = true,
        },
        splitjoin = {
            mappings = {
                toggle = "gS",
                split = "",
                join = "",
            },
            detect = {
                brackets = nil,
                separator = ",",
                exclude_regions = nil,
            },
            split = {
                hooks_pre = {},
                hooks_post = {},
            },
            join = {
                hooks_pre = {},
                hooks_post = {},
            },
        },
        surround = {
            mappings = {
                add = ",sa",
                delete = ",sd",
                find = ",sf",
                find_left = ",sF",
                highlight = ",sh",
                replace = ",sr",
                update_n_lines = ",sn",
                suffix_last = "l",
                suffix_next = "n",
            },
            custom_surroundings = nil,
            highlight_duration = 500,
            n_lines = 100,
            respect_selection_type = false,
            search_method = "cover",
            silent = false,
        },
    },
    flow = {
        bracketed = {
            buffer = {
                suffix = "b",
                options = {},
            },
            comment = {
                suffix = "c",
                options = {},
            },
            conflict = {
                suffix = "x",
                options = {},
            },
            diagnostic = {
                suffix = "d",
                options = {},
            },
            file = {
                suffix = "f",
                options = {},
            },
            indent = {
                suffix = "i",
                options = {},
            },
            jump = {
                suffix = "j",
                options = {},
            },
            location = {
                suffix = "l",
                options = {},
            },
            oldfile = {
                suffix = "o",
                options = {},
            },
            quickfix = {
                suffix = "q",
                options = {},
            },
            treesitter = {
                suffix = "s",
                options = {},
            },
            undo = {
                suffix = "u",
                options = {},
            },
            window = {
                suffix = "w",
                options = {},
            },
            yank = {
                suffix = "y",
                options = {},
            },
        },
        git = {
            job = {
                git_executable = "git",
                timeout = 30000,
            },
            command = {
                split = "tab",
            },
        },
    },
    ui = {
        statusline = {
            content = {
                active = nil,
                inactive = nil,
            },
            use_icons = true,
        },
        trailspace = {
            only_in_normal_buffers = true,
        },
    },
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
                k = {
                    { "%f[%w]%w+" },
                    { "^().*()$" },
                },
                K = {
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
        pairs = function (_, opts)
            local mini_utils = require("akileshas.utils.mini")

            mini_utils.pairs(opts)
        end,
    },
    flow = {
        git = function (_, opts)
            local MiniGit = require("mini.git")
            local utils = require("akileshas.utils")

            local align_blame = function (au_data)
                if au_data.data.git_subcommand ~= "blame" then
                    return
                end

                local win_src = au_data.data.win_source
                wo.wrap = false

                fn.winrestview({
                    topline = fn.line('w0', win_src),
                })

                api.nvim_win_set_cursor( 0, {
                    fn.line('.', win_src),
                    0,
                })

                wo[win_src].scrollbind = true
                wo.scrollbind = true
            end

            -- set folding in git related filetypes
            api.nvim_create_autocmd({ "FileType" }, {
                group = utils.reset_augroup("mini_git_folding"),
                pattern = { "git", "diff" },
                callback = function ()
                    opt_local.foldmethod = "expr"
                    opt_local.foldexpr = [[v:lua.MiniGit.diff_foldexpr()]]
                    opt_local.foldlevel = 0
                end,
            })

            -- align blame output with source
            api.nvim_create_autocmd({ "User" }, {
                group = utils.reset_augroup("mini_git_blame_align"),
                pattern = "MiniGitCommandSplit",
                callback = align_blame,
            })

            MiniGit.setup(opts)
        end,
    },
    ui = {
        statusline = function (_, opts)
            local MiniStatusline = require("mini.statusline")
            -- local mini_utils = require("akileshas.utils.mini")

            -- opts.content.active = mini_utils.active_statusline
            -- opts.content.inactive = mini_utils.inactive_statusline

            MiniStatusline.setup(opts)
        end,
        trailspace = function (_, opts)
            local MiniTrailspace = require("mini.trailspace")
            local utils = require("akileshas.utils")

            api.nvim_create_autocmd({ "BufWritePre" }, {
                group = utils.reset_augroup("mini_trailspace"),
                pattern = { "*" },
                callback = function ()
                    if bo.filetype ~= "oil" then
                        MiniTrailspace.trim()
                        MiniTrailspace.trim_last_lines()
                    end
                end,
            })

            MiniTrailspace.setup(opts)
        end,
    },
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
                    local MiniMove = require("mini.move")

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
                    local MiniMove = require("mini.move")

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
                    local MiniMove = require("mini.move")

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
                    local MiniMove = require("mini.move")

                    MiniMove.move_line("up")
                end,
                noremap = true,
                silent = true,
                desc = "move line up",
            },
        },
        operators = {},
        pairs = {},
        splitjoin = {
            {
                ",gs",
                mode = { "n", "x" },
                function ()
                    local MiniSplitjoin = require("mini.splitjoin")

                    local gen_hook = MiniSplitjoin.gen_hook
                    local bracket = {
                        brackets = {
                            "%b{}",
                            "%b()",
                            "%b[]",
                        },
                    }

                    local add_sep_bracket = gen_hook.add_trailing_separator(bracket)
                    local del_sep_bracket = gen_hook.del_trailing_separator(bracket)
                    local pad_bracket = gen_hook.pad_brackets(bracket)

                    local opts = {
                        split = {
                            hooks_pre = {},
                            hooks_post = {
                                add_sep_bracket,
                            },
                        },
                        join = {
                            hooks_pre = {},
                            hooks_post = {
                                del_sep_bracket,
                                pad_bracket,
                            },
                        },
                    }

                    return MiniSplitjoin.toggle(opts)
                end,
                noremap = true,
                silent = true,
                desc = "toggle split / join with padding & separator",
            },
            {
                ",gS",
                mode = { "n", "x" },
                function ()
                    local MiniSplitjoin = require("mini.splitjoin")

                    local gen_hook = MiniSplitjoin.gen_hook
                    local bracket = {
                        brackets = {
                            "%b{}",
                            "%b()",
                            "%b[]",
                        },
                    }

                    local pad_bracket = gen_hook.pad_brackets(bracket)

                    local opts = {
                        split = {
                            hooks_pre = {},
                            hooks_post = {},
                        },
                        join = {
                            hooks_pre = {},
                            hooks_post = {
                                pad_bracket,
                            },
                        },
                    }

                    MiniSplitjoin.toggle(opts)
                end,
                noremap = true,
                silent = true,
                desc = "toggle split / join with padding",
            },
        },
        surround = {},
    },
    flow = {
        bracketed = {},
        git = {
            {
                "<leader>gc",
                mode = { "n", "x" },
                function ()
                    ui.select(
                        {
                            "vertical split",
                            "horizontal split",
                            "tab",
                        },
                        {
                            prompt = "layout for git context (MiniGit)",
                        },
                        function (choice)
                            if choice == nil then
                                return
                            end

                            local MiniGit = require("mini.git")

                            local split_map = {
                                ["vertical split"] = "vertical",
                                ["horizontal split"] = "horizontal",
                                ["tab"] = "tab",
                            }
                            local split = split_map[choice]

                            if split then
                                MiniGit.show_at_cursor({
                                    split = split,
                                })
                            end
                        end
                    )
                end,
                noremap = true,
                silent = true,
                desc = "show git related data depending on context",
            },
            {
                "<leader>gbf",
                mode = { "n" },
                function ()
                    ui.select(
                        {
                            "vertical split",
                            "horizontal split",
                            "tab",
                        },
                        {
                            prompt = "layout for git blame (MiniGit)",
                        },
                        function (choice)
                            if choice == nil then
                                return
                            end

                            local split_map = {
                                ["vertical split"] = "vertical",
                                ["horizontal split"] = "horizontal",
                                ["tab"] = "tab",
                            }
                            local split = split_map[choice]

                            if split then
                                cmd(split .. " Git blame -- %:p")
                            end
                        end
                    )
                end,
                noremap = true,
                silent = true,
                desc = "show git blame of current file",
            },
        },
    },
    ui = {
        statusline = {},
        trailspace = {},
    },
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
        {
            "echasnovski/mini.operators",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.operators,
            init = init.edit.operators,
            opts = opts.edit.operators,
            keys = keys.edit.operators,
        },
        {
            "echasnovski/mini.pairs",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.pairs,
            init = init.edit.pairs,
            opts = opts.edit.pairs,
            config = config.edit.pairs,
            keys = keys.edit.pairs,
        },
        {
            "echasnovski/mini.splitjoin",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.splitjoin,
            init = init.edit.splitjoin,
            opts = opts.edit.splitjoin,
            keys = keys.edit.splitjoin,
        },
        {
            "echasnovski/mini.surround",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.edit.surround,
            init = init.edit.surround,
            opts = opts.edit.surround,
            keys = keys.edit.surround,
        },
    },

    -- general workflow
    {
        {
            "echasnovski/mini.bracketed",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.flow.bracketed,
            init = init.flow.bracketed,
            opts = opts.flow.bracketed,
            keys = keys.flow.bracketed,
        },
        {
            "echasnovski/mini-git",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.flow.git,
            init = init.flow.git,
            opts = opts.flow.git,
            config = config.flow.git,
            keys = keys.flow.git,
        },
    },

    -- appearance
    {
        {
            "echasnovski/mini.statusline",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.ui.statusline,
            init = init.ui.statusline,
            opts = opts.ui.statusline,
            config = config.ui.statusline,
            keys = keys.ui.statusline,
        },
        {
            "echasnovski/mini.trailspace",
            version = "*",
            enabled = true,
            lazy = true,
            event = {
                "VeryLazy",
            },
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.ui.trailspace,
            init = init.ui.trailspace,
            opts = opts.ui.trailspace,
            config = config.ui.trailspace,
            keys = keys.ui.trailspace,
        },
    },

    -- other
    {},
}
