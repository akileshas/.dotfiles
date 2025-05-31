local api = vim.api
local keymap = vim.keymap

local M = {}

M.map_key = function (mode, lhs, rhs, opts)
    opts = vim.tbl_deep_extend("force", {
        noremap = true,
        silent = true,
    }, opts or {})

    keymap.set(mode, lhs, rhs, opts)
end

M.map_keys = function (keys)
    for _, key in ipairs(keys) do
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

        M.map_key(mode, lhs, rhs, opts)
    end
end

M.set_hl = function (name, val)
    val = val or {}

    api.nvim_set_hl(0, name, val)
end

M.set_hls = function (hls)
    for _, hl in ipairs(hls) do
        local name = hl.name
        local val = hl.val or {}

        M.set_hl(name, val)
    end
end

M.create_autocmd = function (event, opts)
    opts = opts or {
        callback = function () end,
    }

    api.nvim_create_autocmd(event, opts)
end

M.create_autocmds = function (autocmds)
    for _, autocmd in ipairs(autocmds) do
        local event = autocmd.event
        local opts = autocmd.opts or {
            callback = function () end,
        }

        M.create_autocmd(event, opts)
    end
end

M.augroup = function (name, opts)
    opts = opts or {}

    return api.nvim_create_augroup(
        "akileshas_" .. name,
        opts
    )
end

M.reset_augroup = function (name, opts)
    opts = vim.tbl_deep_extend("force", {
        clear = true,
    }, opts or {})

    return api.nvim_create_augroup(
        "akileshas_" .. name,
        opts
    )
end

return M
