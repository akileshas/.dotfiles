-- for convenience
local api = vim.api
local keymap = vim.keymap

local M = {}

M.map = function (mode, lhs, rhs, opts)
    opts = vim.tbl_deep_extend("force", {
        noremap = true,
        silent = true,
    }, opts or {})

    keymap.set(mode, lhs, rhs, opts)
end

M.map_all = function (keymaps)
    for _, key in ipairs(keymaps) do
        local mode = key.mode or { "n" }
        local lhs = key[1]
        local rhs = nil
        local opts = {}

        if type(key[2]) == "function" or type(key[2]) == "string" then
            rhs = key[2]
        else
            rhs = key[3]
        end

        for k, v in pairs(key) do
            if type(k) == "string" and k ~= "mode" then
                opts[k] = v
            end
        end

        M.map(mode, lhs, rhs, opts)
    end
end

M.augroup = function (name)
    return api.nvim_create_augroup(
        "akileshas_" .. name,
        { clear = true }
    )
end

return M
