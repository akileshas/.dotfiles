-- for convenience
local api = vim.api
local bo = vim.bo
local fn = vim.fn
local treesitter = vim.treesitter

local M = {}

M.ai_buffer = function (ai_type)
    local start_line = 1
    local end_line = fn.line("$")

    if ai_type == "i" then
        local first_nonblank = fn.nextnonblank(start_line)
        local last_nonblank = fn.prevnonblank(end_line)

        if first_nonblank == 0 or last_nonblank == 0 then
            return {
                from = {
                    line = start_line,
                    col = 1,
                },
            }
        end

        start_line = first_nonblank
        end_line = last_nonblank
    end

    local to_col = math.max(fn.getline(end_line):len(), 1)

    return {
        from = {
            line = start_line,
            col = 1,
        },
        to = {
            line = end_line,
            col = to_col,
        },
    }
end

M.pairs = function (opts)
    local MiniPairs = require("mini.pairs")
    local open = MiniPairs.open

    MiniPairs.setup(opts)

    MiniPairs.open = function (pair, neigh_pattern)
        if fn.getcmdline() ~= "" then
            return open(pair, neigh_pattern)
        end

        local o = pair:sub(1, 1)
        local c = pair:sub(2, 2)
        local line = api.nvim_get_current_line()
        local cursor = api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])

        if opts.markdown and o == "`" and bo.filetype == "markdown" and before:match("^%s*``") then
            return "`\n```" .. api.nvim_replace_termcodes("<up>", true, true, true)
        end

        if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
            return o
        end

        if opts.skip_ts and #opts.skip_ts > 0 then
            local ok, captures = pcall(
                treesitter.get_captures_at_pos,
                0,
                cursor[1] - 1,
                math.max(cursor[2] - 1, 0)
            )

            for _, capture in ipairs(ok and captures or {}) do
                if vim.tbl_contains(opts.skip_ts, capture.capture) then
                    return o
                end
            end
        end

        return open(pair, neigh_pattern)
    end
end

return M
