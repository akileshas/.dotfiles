-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local ui = vim.ui

local trouble_open = function (base_cmd, prompt)
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
end

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function ()
    local utils = require("akileshas.utils")

    -- automatically open trouble quickfix
    api.nvim_create_autocmd({ "QuickFixCmdPost" }, {
        group = utils.reset_augroup("auto_open_trouble_quickfix"),
        callback = function ()
            cmd("Trouble qflist open")
        end,
    })

    -- open trouble quickfix when the quickfix list opens
    api.nvim_create_autocmd({ "BufRead" }, {
        group = utils.reset_augroup("always_open_trouble_quickfix"),
        callback = function (event)
            if bo[event.buf].buftype == "quickfix" then
                vim.schedule(function ()
                    cmd("cclose")
                    cmd("Trouble qflist open")
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
                "Trouble symbols toggle focus=false",
                "window position for symbols (trouble)"
            )
        end,
        noremap = true,
        silent = true,
        desc = "toggle symbols (trouble)",
    },
    {
        "<leader>xl",
        mode = { "n" },
        function ()
            trouble_open(
                "Trouble lsp toggle focus=false",
                "open position for lsp (trouble)"
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
            cmd("Trouble loclist toggle")
        end,
        noremap = true,
        silent = true,
        desc = "toggle loclist (trouble)",
    },
    {
        "<leader>xq",
        mode = { "n" },
        function ()
            cmd("Trouble qflist toggle")
        end,
        noremap = true,
        silent = true,
        desc = "toggle qflist (trouble)",
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
