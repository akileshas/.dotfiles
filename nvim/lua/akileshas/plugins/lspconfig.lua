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
        "mason-org/mason.nvim",
    },
}

-- diagnostics signs
local signs = {
    ERROR = " ",
    WARN  = " ",
    HINT  = " ",
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
        exclude = {},
    },
    codelens = {
        enabled = false,
        exclude = {},
    },
    capabilities = {
        workspace = {
            fileOperations = {
                didRename = true,
                willRename = true,
            },
        },
    },
    servers = {
        lua_ls = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    telemetry = {
                        enable = false,
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = api.nvim_get_runtime_file("", true),
                    },
                },
            },
        },
    },
}

-- plugin config function
local config = function(_, opts)
    -- for convenience
    local blink_cmp = require("blink.cmp")
    local lspconfig = require("lspconfig")
    local registry = require("mason-registry")

    -- capabilities for lsp server
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp.protocol.make_client_capabilities(),
        blink_cmp.get_lsp_capabilities(),
        opts.capabilities
    )

    -- on_attach function for lsp server
    local on_attach = function(client, bufnr)
        local on_attach_opts = {
            buffer = bufnr,
        }
    end

    -- configure diagnostics signs
    if type(opts.diagnostics.signs) ~= "boolean" then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name

            fn.sign_define(
                name,
                {
                    text = icon,
                    texthl = name,
                    numhl = ""
                }
            )
        end
    end

    -- configure diagnostics
    diagnostic.config(vim.deepcopy(opts.diagnostics))

    -- configure lsp servers

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
