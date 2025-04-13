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
