-- plugin dependencies
local dependencies = {}

-- plugin init function
local init = function () end

-- plugin opts
local opts = {
    logo = "auto",
    logo_tooltip = "nvim",
    main_image = "language",
    show_time = true,
    global_timer = false,
    editing_text = "editing %s",
    file_explorer_text = "browsing %s",
    git_commit_text = "committing changes",
    plugin_manager_text = "managing plugins",
    reading_text = "reading %s",
    workspace_text = "working on %s",
    line_number_text = "line %s out of %s",
    terminal_text = "using terminal",
}

-- plugin keys
local keys = {}

-- plugin configurations
return {
    "IogaMaster/neocord",
    version = "*",
    enabled = true,
    lazy = true,
    event = {
        "VeryLazy",
    },
    cmd = {},
    ft = {},
    build = {},
    dependencies = dependencies,
    init = init,
    opts = opts,
    keys = keys,
}
