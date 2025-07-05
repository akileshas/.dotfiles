-- helper function to define keymaps for harpoon navigation
local keys_for_navigation = function (keys, num)
    for i = 1, num do
        table.insert(keys, {
            "<leader>" .. i,
            mode = { "n" },
            function ()
                -- for convenience
                local harpoon = require("harpoon")

                harpoon:list():select(i)
            end,
            noremap = true,
            silent = true,
            desc = "navigate to harpoon file " .. i,
        })
    end
end

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {}

-- plugin keys
local keys = {
    {
        "<leader>a",
        mode = { "n" },
        function ()
            -- for convenience
            local harpoon = require("harpoon")

            harpoon:list():add()
        end,
        noremap = true,
        silent = true,
        desc = "add file to harpoon",
    },
    {
        "<C-s>",
        mode = { "n" },
        function ()
            -- for convenience
            local harpoon = require("harpoon")

            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        noremap = true,
        silent = true,
        desc = "toggle harpoon quick menu",
    },
    {
        "<leader>hk",
        mode = { "n" },
        function ()
            -- for convenience
            local harpoon = require("harpoon")

            harpoon:list():prev()
        end,
        noremap = true,
        silent = true,
        desc = "move to the previous buffers stored within harpoon list",
    },
    {
        "<leader>hj",
        mode = { "n" },
        function ()
            -- for convenience
            local harpoon = require("harpoon")

            harpoon:list():next()
        end,
        noremap = true,
        silent = true,
        desc = "move to the next buffers stored within harpoon list",
    },
}

-- add keymaps for navigating to harpoon files (1-9)
keys_for_navigation(keys, 9)

-- add keymap for navigating to file 10
table.insert(keys, {
    "<leader>0",
    mode = { "n" },
    function ()
        -- for convenience
        local harpoon = require("harpoon")

        harpoon:list():select(10)
    end,
    noremap = true,
    silent = true,
    desc = "navigate to harpoon file 10",
})

-- plugin configurations
return {
    "ThePrimeagen/harpoon",
    version = "*",
    branch = "harpoon2",
    enabled = true,
    lazy = true,
    event = {},
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
