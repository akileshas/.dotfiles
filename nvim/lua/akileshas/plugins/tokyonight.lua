local cmd = vim.cmd

-- custom theme colors
local on_colors = function (colors) end

-- custom theme highlights
local on_highlights = function (highlights, colors) end

-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function ()
    -- load the tokyonight color scheme
    cmd("colorscheme tokyonight")
end

-- plugin opts
local opts = {
    style = "night",
    light_style = "day",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
    },
    day_brightness = 0.3,
    dim_inactive = false,
    lualine_bold = true,
    on_colors = on_colors,
    on_highlights = on_highlights,
    cache = true,
}

-- plugin keys
local keys = {}

-- plugin specs
local specs = {}

-- plugin configurations
return {
    "folke/tokyonight.nvim",
    version = "*",
    enabled = true,
    lazy = false,
    priority = 1000,
    event = {},
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
    specs = specs,
}
