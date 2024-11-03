return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        -- import mason_tool_installer
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
         mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "html",
                "cssls",
                "lua_ls",
                "emmet_ls",
                "pyright",
                "clangd",
                "cmake",
                "rust_analyzer",
                "bashls",
                "jsonls",
                "ts_ls",
                "eslint",
                "jinja_lsp",
                "dockerls",
                "docker_compose_language_service",
                "gopls",
                "graphql",
                "ast_grep",
                "marksman",
                "asm_lsp",
                "elixirls",
                "rnix",
                "intelephense",
                "sqlls",
                "grammarly",
                "harper_ls",
                "vimls",
                "zls",
                "yamlls",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "eslint_d", -- js linter
            },
        })
    end,
}
