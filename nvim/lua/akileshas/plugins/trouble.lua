-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local log = vim.log
local ui = vim.ui

local is_list_empty = function (list)
    return not list or #list == 0
end

local trouble_open = function (mode, base_cmd, prompt)
    local trouble = require("trouble")

    if mode == "loclist" and is_list_empty(fn.getloclist(0)) then
        vim.notify("`loclist` is empty !!!", log.levels.WARN)
        return
    elseif (mode == "qflist" or mode == "quickfix") and is_list_empty(fn.getqflist()) then
        vim.notify("`qflist` is empty !!!", log.levels.WARN)
        return
    end

    if not trouble.is_open({ mode = mode }) then
        ui.select(
            {
                "left",
                "right",
                "bottom",
                "top",
            },
            {
                prompt = prompt,
            },
            function (choice)
                if choice == nil then
                    return
                end

                local position_map = {
                    ["left"] = "left",
                    ["right"] = "right",
                    ["bottom"] = "bottom",
                    ["top"] = "top",
                }
                local position = position_map[choice]

                if position then
                    cmd(base_cmd .. " win.position=" .. position)
                end
            end
        )
    else
        cmd(base_cmd)
    end
end

-- plugin dependencies
local dependencies = {
    {
        "echasnovski/mini.bracketed",
    },
}

-- plugin init function
local init = function ()
    local utils = require("akileshas.utils")

    -- automatically open trouble quickfix
    api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
        group = utils.reset_augroup("auto_open_trouble_quickfix"),
        callback = function ()
            cmd("Trouble qflist open focus=false")
        end,
    })

    -- open trouble quickfix when the quickfix list opens
    api.nvim_create_autocmd({ "BufRead" }, {
        group = utils.reset_augroup("always_open_trouble_quickfix"),
        callback = function (event)
            if bo[event.buf].buftype == "quickfix" then
                vim.schedule(function ()
                    cmd("cclose")
                    cmd("Trouble qflist open focus=false")
                end)
            end
        end,
    })
end

-- plugin opts
local opts = {}

-- plugin keys
local keys = {
    {
        "<leader>xx",
        mode = { "n" },
        function ()
            trouble_open(
                "diagnostics",
                "Trouble diagnostics toggle focus=false",
                "window position for diagnostics (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle diagnostics for workspace (trouble)",
    },
    {
        "<leader>xX",
        mode = { "n" },
        function ()
            trouble_open(
                "diagnostics",
                "Trouble diagnostics toggle focus=false filter.buf=0",
                "window position for diagnostics (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle diagnostics for current buffer (trouble)",
    },
    {
       "<leader>xs",
        mode = { "n" },
        function ()
            trouble_open(
                "symbols",
                "Trouble symbols toggle focus=false",
                "window position for symbols (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle symbols (trouble)",
    },
    {
        "<leader>xS",
        mode = { "n" },
        function ()
            trouble_open(
                "lsp_document_symbols",
                "Trouble lsp_document_symbols toggle focus=false",
                "window position for lsp symbols (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle lsp symbols (trouble)",
    },
    {
        "<leader>xl",
        mode = { "n" },
        function ()
            trouble_open(
                "lsp",
                "Trouble lsp toggle focus=false",
                "window position for lsp (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle lsp definitions / references / ... (trouble)",
    },
    {
        "<leader>xL",
        mode = { "n" },
        function ()
            trouble_open(
                "loclist",
                "Trouble loclist toggle focus=false",
                "window position for loclist (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle loclist (trouble)",
    },
    {
        "<leader>xq",
        mode = { "n" },
        function ()
            trouble_open(
                "qflist",
                "Trouble qflist toggle focus=false",
                "window position for qflist (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle qflist (trouble)",
    },
    {
        "]q",
        mode = { "n" },
        function ()
            local trouble = require("trouble")

            if trouble.is_open() then
                trouble.next({
                    skip_groups = true,
                    jump = true,
                })
            else
                local MiniBracketed = require("mini.bracketed")

                local ok, error = pcall(function ()
                    MiniBracketed.quickfix("forward")
                end)

                if not ok then
                    vim.notify(error, log.levels.ERROR)
                end
            end
        end,
        noremap = true,
        silent = true,
        desc = "jump to next trouble / quickfix item",
    },
    {
        "[q",
        mode = { "n" },
        function ()
            local trouble = require("trouble")

            if trouble.is_open() then
                trouble.prev({
                    skip_groups = true,
                    jump = true,
                })
            else
                local MiniBracketed = require("mini.bracketed")

                local ok, error = pcall(function ()
                    MiniBracketed.quickfix("backward")
                end)

                if not ok then
                    vim.notify(error, log.levels.ERROR)
                end
            end
        end,
        noremap = true,
        silent = true,
        desc = "jump to previous trouble / quickfix item",
    },
}

-- plugin configurations
return {
    "folke/trouble.nvim",
    version = "*",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {
        "Trouble",
    },
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
