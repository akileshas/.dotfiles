-- for convenience
local api = vim.api
local cmd = vim.cmd

-- list of lsp servers and tools ( dap, linter, formatter ) to be installed
local ensure_installed = {
    lsp = {
        "lua-language-server",
        "clangd",
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "bash-language-server",
        "python-lsp-server",
    },
    tools = {
        "stylua",
        "shfmt",
        "black",
    },
}

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

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
local config = function (_, opts)
    -- for convenience
    local mason = require("mason")
    local mreg = require("mason-registry")

    -- autimatically install required lsp servers and tools
    local ensure_tools_installed = function ()
        local tools = {}
        vim.list_extend(tools, opts.ensure_installed.lsp)
        vim.list_extend(tools, opts.ensure_installed.tools)

        for _, tool in ipairs(tools) do
            if mreg.has_package(tool) then
                local pkg = mreg.get_package(tool)

                if not pkg:is_installed() then
                    pkg:install()
                end
            end
        end
    end

    -- delay filetype event trigger
    local queue_filetype_event = function ()
        local event = require("lazy.core.handler.event")

        local trigger_filetype_event = function ()
            local trigger_opts = {
                event = "FileType",
                buf = api.nvim_get_current_buf(),
            }

            event.trigger(trigger_opts)
        end

        vim.defer_fn(trigger_filetype_event, 100)
    end

    -- configure mason
    mason.setup(opts)

    -- ensure the necessary tools are installed
    mreg.refresh(ensure_tools_installed)

    -- load the newly installed lsp server
    mreg:on("package:install:success", queue_filetype_event)
end

-- plugin keys
local keys = {
    {
        "<leader>cm",
        mode = { "n" },
        function ()
            cmd("Mason")
        end,
        noremap = true,
        silent = true,
        desc = "open the mason window",
    },
}

-- plugin configurations
return {
    "mason-org/mason.nvim",
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
