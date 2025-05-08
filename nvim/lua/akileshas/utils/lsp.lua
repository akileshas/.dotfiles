-- for convenience
local lspconfig = require("lspconfig")

local M = {}

M.is_enabled = function (server)
    local c = lspconfig.configs[server]

    return c and c.enabled ~= false
end

M.disable = function (server, cond)
    local defn = lspconfig.configs[server]

    if not defn or not defn.document_config then
        return
    end

    local org_on_new_config = defn.document_config.on_new_config

    defn.document_config.on_new_config = function (config, root_dir)
        if cond(root_dir, config) then
            config.enabled = false
        end

        if org_on_new_config then
            org_on_new_config(config, root_dir)
        end
    end
end

return M
