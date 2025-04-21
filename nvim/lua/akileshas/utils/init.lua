-- for convenience
local api = vim.api
local b = vim.b
local bo = vim.bo
local fn = vim.fn
local treesitter = vim.treesitter
local v = vim.v

local M = {}

function M.foldexpr()
    local buf = api.nvim_get_current_buf()

    if b[buf].ts_folds == nil then
        -- as long as we don't have a filetype, don't bother
        -- checking if treesitter is available (it won't)
        if bo[buf].filetype == "" then
            return "0"
        end
        if bo[buf].filetype:find("dashboard") then
            b[buf].ts_folds = false
        else
            b[buf].ts_folds = pcall(treesitter.get_parser, buf)
        end
    end

    return b[buf].ts_folds and treesitter.foldexpr() or "0"
end

function M.foldtext()
    local first_line = fn.getline(v.foldstart)
    local folded_lines = v.foldend - v.foldstart + 1

    return "+--- " .. folded_lines .. " lines: " .. first_line .. " ..."
end

return M
