-- for convenience
local keymap = vim.keymap

local M = {}

M.map = function (mode, lhs, rhs, opts)
    opts = vim.tbl_deep_extend("force", {
        silent = true,
        noremap = true,
    }, opts or {})

    keymap.set(mode, lhs, rhs, opts)
end

return M
