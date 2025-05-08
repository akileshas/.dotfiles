-- plugin dependencies
local dependencies = {
    edit = {
        ai = {},
    },
    flow = {},
    ui = {
        statusline = {
            {
                "nvim-tree/nvim-web-devicons",
            },
        },
    },
    etc = {},
}

-- plugin init function
local init = {
    edit = {
        ai = function () end,
    },
    flow = {},
    ui = {
        statusline = function () end,
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
                around_last = "ap",
                inside_last = "ip",
                goto_left = "g[",
                goto_right = "g]",
            },
            n_lines = 1000000000,
            search_method = "cover_or_next",
        },
    },
    flow = {},
    ui = {
        statusline = {
            use_icons = true,
            content = {
                active = function ()
                    local active_opts = {
                        mode = {
                            trunc_width = 120,
                        },
                        git = {
                            trunc_width = 40,
                        },
                        diff = {
                            trunc_width = 75,
                        },
                        diagnostics = {
                            trunc_width = 75,
                        },
                        lsp = {
                            trunc_width = 75,
                        },
                        filename = {
                            trunc_width = 140,
                        },
                        fileinfo = {
                            trunc_width = 120,
                        },
                        location = {
                            trunc_width = 75,
                        },
                        search = {
                            trunc_width = 75,
                        },
                    }

                    local mode, mode_hl = MiniStatusline.section_mode(active_opts.mode)
                    local git = MiniStatusline.section_git(active_opts.git)
                    local diff = MiniStatusline.section_diff(active_opts.diff)
                    local diagnostics = MiniStatusline.section_diagnostics(active_opts.diagnostics)
                    local lsp = MiniStatusline.section_lsp(active_opts.lsp)
                    local filename = MiniStatusline.section_filename(active_opts.filename)
                    local fileinfo = MiniStatusline.section_fileinfo(active_opts.fileinfo)
                    local location = MiniStatusline.section_location(active_opts.location)
                    local search = MiniStatusline.section_searchcount(active_opts.search)

                    local groups = {
                        {
                            hl = mode_hl,
                            strings = {
                                mode,
                            },
                        },
                        {
                            hl = "MiniStatuslineDevinfo",
                            strings = {
                                git,
                                diff,
                                diagnostics,
                                lsp,
                            },
                        },
                        "%<",
                        {
                            hl = "MiniStatuslineFilename",
                            strings = {
                                filename,
                            },
                        },
                        "%=",
                        {
                            hl = "MiniStatuslineFileinfo",
                            strings = {
                                fileinfo,
                            },
                        },
                        {
                            hl = mode_hl,
                            strings = {
                                search,
                                location,
                            },
                        },
                    }

                    return MiniStatusline.combine_groups(groups)
                end,
                inactive = function ()
                    return "%#MiniStatuslineInactive#%F%="
                end,
            },
        },
    },
    etc = {},
}

-- plugin keys
local keys = {
    edit = {
        ai = {},
    },
    flow = {},
    ui = {
        statusline = {},
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
            init = init.edit.ai,
            opts = opts.edit.ai,
            keys = keys.edit.ai,
        },
    },

    -- general workflow
    {},

    -- appearance
    {
        {
            "echasnovski/mini.statusline",
            version = "*",
            enabled = true,
            lazy = false,
            priority = 100,
            event = {},
            cmd = {},
            ft = {},
            build = {},
            dependencies = dependencies.ui.statusline,
            init = init.ui.statusline,
            opts = opts.ui.statusline,
            keys = keys.ui.statusline,
        },
    },

    -- other
    {},
}
