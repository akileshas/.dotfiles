-- plugin keymaps
local keymaps = {
    -- search keymaps
    {
        '<leader>s"',
        mode = "n",
        function()
            Snacks.picker.registers()
        end,
        noremap = true,
        silent = true,
        desc = "search for a register",
    },
    {
        "<leader>s/",
        mode = "n",
        function()
            Snacks.picker.search_history()
        end,
        noremap = true,
        silent = true,
        desc = "search history",
    },
    {
        "<leader>sm",
        mode = "n",
        function()
            Snacks.picker.man()
        end,
        noremap = true,
        silent = true,
        desc = "search the man pages",
    },
    {
        "<leader>sM",
        mode = "n",
        function()
            Snacks.picker.marks()
        end,
        noremap = true,
        silent = true,
        desc = "search for marks",
    },
    {
        "<leader>sP",
        mode = "n",
        function()
            Snacks.picker.lazy()
        end,
        noremap = true,
        silent = true,
        desc = "search for plugins specs",
    },
    {
        "<leader>sq",
        mode = "n",
        function()
            Snacks.picker.qflist()
        end,
        noremap = true,
        silent = true,
        desc = "search for qflist",
    },
    {
        "<leader>sr",
        mode = "n",
        function()
            Snacks.picker.resume()
        end,
        noremap = true,
        silent = true,
        desc = "resume the last search",
    },
    {
        "<leader>su",
        mode = "n",
        function()
            Snacks.picker.undo()
        end,
        noremap = true,
        silent = true,
        desc = "search for undo history",
    },
    {
        "<leader>sz",
        mode = "n",
        function()
            Snacks.picker.zoxide()
        end,
        noremap = true,
        silent = true,
        desc = "search for zoxide",
    },
}

-- plugin init function
local init = function()
    -- autocmd for the lazy event
    api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            -- setup some globals for debugging (lazy-loaded)
            _G.dd = function(...)
                Snacks.debug.inspect(...)
            end
            _G.bt = function()
                Snacks.debug.backtrace()
            end

            -- override print to use snacks for `:=` command
            vim.print = _G.dd
        end,
    })
end
