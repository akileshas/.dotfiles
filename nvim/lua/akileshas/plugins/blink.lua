-- for convenience
local bo = vim.bo
local fn = vim.fn

local devicons = require("nvim-web-devicons")

local cmp_keymap = {
    preset = "none",
    ["<C-space>"] = {
        "show_documentation",
        "hide_documentation",
    },
    ["<C-s>"] = {
        "show",
    },
    ["<C-e>"] = {
        "cancel",
    },
    ["<C-y>"] = {},
    ["<C-k>"] = {
        "select_and_accept",
    },
    ["<C-p>"] = {
        "select_prev",
        "snippet_backward",
    },
    ["<C-n>"] = {
        "select_next",
        "snippet_forward",
    },
    ["<Up>"] = {},
    ["<Down>"] = {},
    ["<Left>"] = {},
    ["<Right>"] = {},
    ["<C-b>"] = {
        "scroll_documentation_up",
    },
    ["<C-f>"] = {
        "scroll_documentation_down",
    },
    ["<Tab>"] = {},
    ["<S-Tab>"] = {},
    ["<C-d>"] = {
        "show_signature",
        "hide_signature",
    },
}

-- plugin dependencies
local dependencies = {
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "folke/lazydev.nvim",
    },
    {
        "moyiz/blink-emoji.nvim",
    },
}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    enabled = function ()
        local filetype = bo[0].filetype
        if filetype == "oil" or filetype == "snacks_picker_input" then
            return false
        end
        return true
    end,
    snippets = {
        preset = "default",
    },
    completion = {
        list = {
            max_items = 300,
            selection = {
                preselect = true,
                auto_insert = true,
            },
            cycle = {
                from_bottom = true,
                from_top = true,
            },
        },
        accept = {
            dot_repeat = true,
            create_undo_point = true,
            auto_brackets = {
                enabled = true,
            },
        },
        menu = {
            border = "rounded",
            scrollbar = true,
            auto_show = true,
            draw = {
                treesitter = { "lsp" },
                columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind" },
                },
                components = {
                    kind_icon = {
                        text = function (ctx)
                            local icon = ctx.kind_icon
                            if vim.tbl_contains({ "path" }, ctx.source_name) then
                                local dev_icon, _ = devicons.get_icon(ctx.label)
                                if dev_icon then
                                    icon = dev_icon
                                end
                            end

                            return icon .. ctx.icon_gap
                        end,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            update_delay_ms = 50,
            treesitter_highlighting = true,
            window = {
                border = "rounded",
                scrollbar = true,
            },
        },
        ghost_text = {
            enabled = false,
        },
    },
    signature = {
        enabled = true,
        trigger = {
            show_on_insert = false,
        },
        window = {
            border = "rounded",
            scrollbar = false,
            treesitter_highlighting = true,
            show_documentation = true,
        },
    },
    fuzzy = {
        implementation = "prefer_rust",
        sorts = {
            "exact",
            "score",
            "sort_text",
        },
    },
    sources = {
        default = {
            "lazydev",
            "lsp",
            "omni",
            "emoji",
            "snippets",
            "path",
            "buffer",
        },
        providers = {
            lazydev = {
                name = "lazydev",
                enabled = true,
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
            lsp = {
                name = "lsp",
                enabled = true,
                module = "blink.cmp.sources.lsp",
                score_offset = 95,
            },
            omni = {
                name = "omni",
                enabled = function ()
                    return bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
                end,
                module = "blink.cmp.sources.complete_func",
                score_offset = 90,
                opts = {
                    complete_func = function ()
                        return bo.omnifunc
                    end,
                },
            },
            emoji = {
                name = "emoji",
                enabled = true,
                module = "blink-emoji",
                score_offset = 85,
                opts = {
                    insert = true,
                },
            },
            snippets = {
                name = "snippets",
                enabled = true,
                module = "blink.cmp.sources.snippets",
                score_offset = 80,
                max_items = 15,
            },
            path = {
                name = "path",
                enabled = true,
                module = "blink.cmp.sources.path",
                score_offset = 10,
                fallbacks = { "snippets", "buffer" },
                opts = {
                    trailing_slash = true,
                    label_trailing_slash = true,
                    get_cwd = function (context)
                        return fn.expand(("#%d:p:h"):format(context.bufnr))
                    end,
                    show_hidden_files_by_default = true,
                },
            },
            buffer = {
                name = "buffer",
                enabled = true,
                module = "blink.cmp.sources.buffer",
                score_offset = 5,
                max_items = 5,
            },
            cmdline = {
                name = "cmdline",
                enabled = function ()
                    return fn.has("win32") == 0
                        or fn.getcmdtype() ~= ":"
                        or not fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                end,
                module = "blink.cmp.sources.cmdline",
            },
        },
    },
    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },
    cmdline = {
        enabled = true,
        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
            menu = {
                auto_show = true,
            },
            ghost_text = {
                enabled = false,
            },
        },
        keymap = cmp_keymap,
    },
    term = {
        enabled = false,
        completion = {
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
            menu = {
                auto_show = true,
            },
            ghost_text = {
                enabled = false,
            },
        },
        keymap = cmp_keymap,
    },
    keymap = cmp_keymap,
}

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "saghen/blink.cmp",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "InsertEnter",
        "CmdlineEnter",
    },
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
