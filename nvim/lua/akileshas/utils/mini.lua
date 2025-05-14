-- for convenience
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

return M
