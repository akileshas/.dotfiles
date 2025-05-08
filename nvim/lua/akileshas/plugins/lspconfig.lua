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
local init = function () end

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
local config = function (_, opts)
    -- for convenience
    local blink_cmp = require("blink.cmp")
    local mreg = require("mason-registry")

    -- capabilities for lsp server
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp.protocol.make_client_capabilities(),
        blink_cmp.get_lsp_capabilities(),
        opts.capabilities or {}
    )

    -- on_attach function for lsp server
    local on_attach = function (client, bufnr) end

    -- function to setup an lsp server
    local setup = function (server)
        local server_opts = vim.tbl_deep_extend(
            "force",
            {
                capabilities = capabilities,
            },
            (opts.servers and opts.servers[server]) or {}
        )

        if server_opts.enabled == false then
            return
        end

        lsp.config(server, server_opts)
        lsp.enable(server)
    end

    -- function to configure lsp
    local configure = function ()
        local installed_packages = {}

        for _, pkg_name in ipairs(mreg.get_installed_package_names()) do
            installed_packages[pkg_name] = true
        end

        for _, pkg_spec in ipairs(mreg.get_all_package_specs()) do
            local lsp_server = vim.tbl_get(pkg_spec, "neovim", "lspconfig")
            if lsp_server and installed_packages[pkg_spec.name] then
                setup(lsp_server)
            end
        end
    end

    -- configure diagnostics
    if opts.diagnostics then
        diagnostic.config(opts.diagnostics)
    end

    -- configure lsp servers
    configure()
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
