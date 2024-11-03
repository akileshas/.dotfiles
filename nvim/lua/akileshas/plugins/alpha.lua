return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "    _             _     _ _                        ",
            "   / \\   _ __ ___| |__ | (_)_ __  _   ___  __     ",
            "  / _ \\ | '__/ __| '_ \\| | | '_ \\| | | \\ \\/ / ",
            " / ___ \\| | | (__| | | | | | | | | |_| |>  <      ",
            "/_/   \\_\\_|  \\___|_| |_|_|_|_| |_|\\__,_/_/\\_\\",
        }

        -- Set menu
        dashboard.section.buttons.val = {}

        -- Send config to alpha
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
