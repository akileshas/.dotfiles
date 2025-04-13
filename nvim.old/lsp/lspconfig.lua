return {
    config = function()
        -- LSP Keymap
        api.nvim_create_autocmd("LspAttach", {
            group = api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = {
                    buffer = ev.buf,
                    silent = true,
                }

                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
                    desc = "See available code actions",
                    unpack(opts),
                })
                keymap.set("n", "<leader>rn", lsp.buf.rename, {
                    desc = "Smart rename",
                    unpack(opts),
                })

                keymap.set("n", "<leader>D", diagnostic.open_float, {
                    desc = "Show line diagnostics",
                    unpack(opts),
                })
                keymap.set("n", "[d", diagnostic.goto_prev, {
                    desc = "Go to previous diagnostic",
                    unpack(opts),
                })
                keymap.set("n", "]d", diagnostic.goto_next, {
                    desc = "Go to next diagnostic",
                    unpack(opts),
                })

                keymap.set("n", "K", lsp.buf.hover, {
                    desc = "Show documentation",
                    unpack(opts),
                })

                keymap.set("n", "<leader>rs", ":LspRestart<CR>", {
                    desc = "Restart LSP",
                    unpack(opts),
                })
            end,
        })
    end,
}
