-- for convenience
local api = vim.api
local cmd = vim.cmd
local diagnostic = vim.diagnostic
local fn = vim.fn
local keymap = vim.keymap
local lsp = vim.lsp

-- plugin dependencies
local dependencies = {
    {
        "williamboman/mason.nvim",
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
}

-- diagnostics signs
local signs = {
    ERROR = " ",
    WARN  = " ",
    HINT  = " ",
    -- HINT = "󰠠 ",
    INFO  = " ",
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
    diagnostics = {
        underline = false,
        virtual_text = false,
        virtual_lines = false,
        update_in_insert = false,
        severity_sort = true,
        float = {
            source = true,
            border = "rounded",
        },
        signs = {
            text = {
                [diagnostic.severity.ERROR] = signs.ERROR,
                [diagnostic.severity.WARN] = signs.WARN,
                [diagnostic.severity.HINT] = signs.HINT,
                [diagnostic.severity.INFO] = signs.INFO,
            },
        },
    },
    inlay_hints = {
        enabled = false,
    },
    codelens = {
        enabled = false,
    },
}

-- plugin config function
local config = function(_, opts)
    -- for convenience
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local blink_cmp = require("blink.cmp")

    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp.protocol.make_client_capabilities(),
        blink_cmp.get_lsp_capabilities()
    )

    -- on_attach function for lsp server
    local on_attach = function(client, bufnr) end

    -- default setup for lsp server
    local default_setup = function(server_name)
        local default_lsp_config = {
            capabilities = capabilities,
            on_attach = on_attach,
        }

        lspconfig[server_name].setup(default_lsp_config)
    end

    if opts == nil then
        opts = {}
    end

    -- configure diagnostics
    diagnostic.config(opts.diagnostics)

    -- automatically setup each server installed by mason
    local handlers = {
        default_setup,
        lua_ls = function()
            local lua_ls_config = {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            lspconfig.lua_ls.setup(lua_ls_config)
        end,
    }
    mason_lspconfig.setup_handlers(handlers)
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "neovim/nvim-lspconfig",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "BufReadPost",
        "BufNewFile",
        "BufWritePre",
    },
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    config = config,
    keys = keys,
}
