-- for convenience
local api = vim.api
local bo = vim.bo
local fn = vim.fn

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

        return open(pair, neigh_pattern)
    end
end

return M
