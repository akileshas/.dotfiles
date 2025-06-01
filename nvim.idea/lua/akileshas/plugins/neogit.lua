return {
    {
        "echasnovski/mini.diff",
        lazy = true,
        opts = {
            view = {
                style = "sign",
            }
        },
        config = function (_, opts)
            local MiniDiff = require "mini.diff"
            -- MiniDiff.setup(opts)
        end
    },
}
