return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", -- follow latest release
			build = "make install_jsregexp", -- install jsregexp (optional)
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion with LuaSnip
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- VS-Code like pictograms
		"hrsh7th/cmp-nvim-lsp", -- Enables completion from LSP servers
		"hrsh7th/cmp-nvim-lsp-signature-help", -- Adds signature help (function arguments) in completion popups
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Load VSCode-style snippets from installed plugins (e.g., friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-l>"] = cmp.mapping.confirm({ select = false }),
				["<C-s>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp_signature_help" }, -- function signature help
				{ name = "nvim_lsp" }, -- LSP completion
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within the current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
