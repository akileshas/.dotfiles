return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- JavaScript, TypeScript, JSX, TSX, CSS, HTML, JSON, YAML, Markdown, Liquid
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                liquid = { "prettier" },

                -- Lua
                lua = { "stylua" },

                -- Python
                python = {
                    "isort",
                    "black",
                    "autopep8",
                },

                -- Go
                go = {
                    "golines",
                    "goimports",
                    "gofumpt",
                },

                -- Rust
                rust = { "rustfmt" },

                -- Shell scripts
                sh = { "shfmt" },

                -- Haskell
                haskell = { "ormolu" },
            },
        })

        -- Keybinding to format the current file or selected range (visual mode)
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = true,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
