-- for convenience
local api = vim.api
local cmd = vim.cmd

-- list of lsp servers and tools to be installed
local ensure_installed = {
    lsp = {
        "lua_ls",
        "clangd",
        "gopls",
        "rust_analyzer",
        "ts_ls",
    },
    tools = {
        "stylua",
        "shfmt",
        "black",
    },
}

-- plugin dependencies
local dependencies = {
    {
        "neovim/nvim-lspconfig",
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
    max_concurrent_installers = 8,
    ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        backdrop = 60,
        width = 0.8,
        height = 0.8,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
            toggle_package_install_log = "<CR>",
            toggle_help = "g?",
        },
    },
    ensure_installed = ensure_installed,
}

-- plugin config function
local config = function(_, opts)
    -- for convenience
    local mason = require("mason")
    local mason_registry = require("mason-registry")
    local mason_lspconfig = require("mason-lspconfig")

    local mason_lspconfig_opts = {
        ensure_installed = opts.ensure_installed.lsp,
        automatic_installation = true,
    }

    local ensure_tools_installed = function()
        local tools = {}
        vim.list_extend(tools, opts.ensure_installed.lsp)
        vim.list_extend(tools, opts.ensure_installed.tools)

        for _, tool in ipairs(tools) do
            if mason_registry.has_package(tool) then
                local p = mason_registry.get_package(tool)

                if not p:is_installed() then
                    p:install()
                end
            end
        end
    end

    local queue_filetype_event = function()
        local event = require("lazy.core.handler.event")

        local trigger_filetype_event = function()
            local trigger_opts = {
                event = "FileType",
                buf = api.nvim_get_current_buf(),
            }

            event.trigger(trigger_opts)
        end

        vim.defer_fn(trigger_filetype_event, 100)
    end

    if opts == nil then
        opts = {}
    end

    -- configure mason
    mason.setup(opts)

    -- configure mason-lspconfig
    mason_lspconfig.setup(mason_lspconfig_opts)

    -- trigger FileType event to possibly load this newly installed lsp server
    mason_registry:on("package:install:success", queue_filetype_event)

    -- refresh the mason registry by ensuring the tools are installed
    mason_registry.refresh(ensure_tools_installed)
end

-- plugin keys
local keys = {
    {
        "<leader>cm",
        mode = { "n" },
        function()
            cmd("Mason")
        end,
        noremap = true,
        silent = true,
        desc = "open the mason window",
    },
}

-- plugin configurations
return {
    "williamboman/mason.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {
        "Mason",
    },
    ft = {},
    build = {
        ":MasonUpdate",
    },
    dependencies = dependencies,
    init = init,
    opts = opts,
    config = config,
    keys = keys,
}
