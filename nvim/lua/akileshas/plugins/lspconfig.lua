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
        "saghen/blink.cmp",
    },
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
                    diagnostics = {
                        globals = { "vim" },
                    },
                    runtime = {
                        version = "LuaJIT",
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
    local lsp_utils = require("akileshas.utils.lsp")
    local mreg = require("mason-registry")
    local utils = require("akileshas.utils")

    -- capabilities for lsp server
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        lsp.protocol.make_client_capabilities(),
        blink_cmp.get_lsp_capabilities(),
        opts.capabilities or {}
    )

    -- on_attach function for lsp server
    local on_attach = function (client, buffer)
        local keys = {
            {
                "gd",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_definitions()
                end,
                desc = "go to definitions",
            },
            {
                "gD",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_declarations()
                end,
                desc = "go to declarations",
            },
            {
                "gt",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = "go to type definitions",
            },
            {
                "gri",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_implementations()
                end,
                desc = "go to implementations",
            },
            {
                "grr",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_references()
                end,
                desc = "go to references",
            },
            {
                "<leader>lc",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_config()
                end,
                desc = "lsp server config",
            },
            {
                "<leader>ls",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "lsp symbols in current buffer",
            },
            {
                "<leader>lS",
                mode = { "n" },
                function ()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = "lsp symbols in workspace",
            },
            {
                "<leader>li",
                mode = { "n" },
                function ()
                    cmd("LspInfo")
                end,
                desc = "lsp server info",
            },
            {
                "K",
                mode = { "n" },
                function ()
                    lsp.buf.hover({
                        border = "rounded",
                    })
                end,
                desc = "lsp hover",
            },
            {
                "gK",
                mode = { "n" },
                function ()
                    lsp.buf.signature_help({
                        border = "rounded",
                    })
                end,
                desc = "lsp signature help",
            },
            {
                "<C-w><C-d>",
                mode = { "n" },
                function ()
                    diagnostic.open_float()
                end,
                desc = "show diagnostic under the cursor",
            },
        }

        -- mapping all the keys
        utils.map_all(keys)
    end

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
            Snacks.notify.warn("LSP server " .. server .. " is disabled !!!")
            return
        end

        lsp.config(server, server_opts)
        lsp.enable(server)
    end

    -- dynamically handle the installed lsp servers
    local handler = function ()
        local enabled_servers = {}

        -- enable an lsp server
        local enable_server = function (pkg)
            local pkg_obj

            if type(pkg) == "string" then
                local ok, result = pcall(function ()
                    return mreg.get_package(pkg)
                end)

                if not ok then
                    Snacks.notify.error("Package " .. pkg .. " not found !!!")
                    return
                end

                pkg_obj = result
            else
                pkg_obj = pkg
            end

            local lsp_server = vim.tbl_get(pkg_obj, "spec", "neovim", "lspconfig")

            if not lsp_server or enabled_servers[lsp_server] then
                return
            end

            setup(lsp_server)
            enabled_servers[lsp_server] = true
        end

        local enable_server_scheduled = vim.schedule_wrap(enable_server)

        for _, pkg_name in ipairs(mreg.get_installed_package_names()) do
            enable_server(pkg_name)
        end

        mreg:off("package:install:success", enable_server_scheduled)
        mreg:on("package:install:success", enable_server_scheduled)
    end

    -- configure diagnostics
    if opts.diagnostics then
        diagnostic.config(opts.diagnostics)
    end

    -- configure lsp servers
    handler()

    -- setup the keymaps on attach
    lsp_utils.on_attach(on_attach)
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
