return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- for convenience
		local keymap = vim.keymap
		local api = vim.api
		local fn = vim.fn
		local cmd = vim.cmd
		local diagnostic = vim.diagnostic
		local lsp = vim.lsp

		-- Set up autocompletion capabilities
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Custom diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			fn.sign_define(hl, {
				text = icon,
				texthl = hl,
				numhl = hl,
			})
		end

		diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = false,
			update_in_insert = false,
			severity_sort = true,
		})

		-- LSP Keymap
		api.nvim_create_autocmd("LspAttach", {
			group = api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = {
					buffer = ev.buf,
					silent = true,
				}

				keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", {
					desc = "Show LSP references",
					unpack(opts),
				})
				keymap.set("n", "gD", lsp.buf.declaration, {
					desc = "Go to declaration",
					unpack(opts),
				})
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", {
					desc = "Show LSP definitions",
					unpack(opts),
				})
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", {
					desc = "Show LSP implementations",
					unpack(opts),
				})
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", {
					desc = "Show LSP type definitions",
					unpack(opts),
				})

				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {
					desc = "See available code actions",
					unpack(opts),
				})
				keymap.set("n", "<leader>rn", lsp.buf.rename, {
					desc = "Smart rename",
					unpack(opts),
				})

				keymap.set("n", "<leader>sD", "<cmd>Telescope diagnostics bufnr=0<CR>", {
					desc = "Show buffer diagnostics",
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

		-- Automatically setup each server installed by mason
		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
