-- for convenience
local api = vim.api
local lsp = vim.lsp

local utils = require("akileshas.utils")

local M = {}

M.on_attach = function (on_attach, name)
    return api.nvim_create_autocmd({ "LspAttach" }, {
        group = utils.reset_augroup("lsp_attach" .. ((name and ("_" .. name)) or "")),
        callback = function (args)
            local buffer = args.buf
            local client = lsp.get_client_by_id(args.data.client_id)

            if client and (not name or client.name == name) then
                return on_attach(client, buffer)
            end
        end,
    })
end

return M
