-- list of lsp servers to be installed
local ensure_installed = {
    "lua_ls",
    "clangd",
    "gopls",
    "rust_analyzer",
}

-- plugin dependencies
local dependencies = {
    {
        "saghen/blink.cmp",
    },
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
}

-- plugin config function
local config = function(_, opts)
    -- for convenience
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    if opts == nil then
        opts = {}
    end

    -- configure mason
    mason.setup(opts)

    -- configure mason-lspconfig
    mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
    })
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "williamboman/mason.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {
        "Mason",
        "MasonUpdate",
    },
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    config = config,
    keys = keys,
}
