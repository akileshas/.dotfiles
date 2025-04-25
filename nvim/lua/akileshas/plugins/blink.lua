-- for convenience
local bo = vim.bo
local fn = vim.fn

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
    {
        "giuxtaposition/blink-cmp-copilot",
    },
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
    enabled = function()
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
            "copilot",
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
                enabled = function()
                    return bo.omnifunc ~= "v:lua.vim.lsp.omnifunc"
                end,
                module = "blink.cmp.sources.complete_func",
                score_offset = 90,
                opts = {
                    complete_func = function()
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
            copilot = {
                name = "copilot",
                enabled = true,
                module = "blink-cmp-copilot",
                score_offset = 15,
                async = true,
                transform_items = function(_, items)
                    local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                    local kind_idx = #CompletionItemKind + 1
                    CompletionItemKind[kind_idx] = "Copilot"
                    for _, item in ipairs(items) do
                        item.kind = kind_idx
                    end
                    return items
                end,
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
                    get_cwd = function(context)
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
        keymap = {
            preset = "cmdline",
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
                "fallback",
            },
            ["<C-n>"] = {
                "select_next",
                "snippet_forward",
                "fallback",
            },
            ["<Up>"] = {},
            ["<Down>"] = {},
            ["<Right>"] = {},
            ["<Left>"] = {},
            ['<C-b>'] = {
                "scroll_documentation_up",
                "fallback",
            },
            ['<C-f>'] = {
                "scroll_documentation_down",
                "fallback",
            },
            ["<Tab>"] = {},
            ["<S-Tab>"] = {},
            ["<C-d>"] = {
                "show_signature",
                "hide_signature",
                "fallback",
            },
        },
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
    },
    keymap = {
        preset = "default",
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
            "fallback",
        },
        ["<C-n>"] = {
            "select_next",
            "snippet_forward",
            "fallback",
        },
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Right>"] = {},
        ["<Left>"] = {},
        ['<C-b>'] = {
            "scroll_documentation_up",
            "fallback",
        },
        ['<C-f>'] = {
            "scroll_documentation_down",
            "fallback",
        },
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-d>"] = {
            "show_signature",
            "hide_signature",
            "fallback",
        },
    },
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
