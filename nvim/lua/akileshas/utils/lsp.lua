-- for convenience
local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")

local M = {}

M.is_enabled = function (server)
    local c = lspconfig.configs[server]

    return c and c.enabled ~= false
end

M.disable = function (server, cond)
    local def = lspconfig.configs[server]
end

return M
