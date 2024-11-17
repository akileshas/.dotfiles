return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- Enable mason with icon settings
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Set up mason-lspconfig to install required servers
		mason_lspconfig.setup({
			ensure_installed = {
				"html",
				"cssls",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"clangd",
				"cmake",
				"rust_analyzer",
				"bashls",
				"jsonls",
				"ts_ls",
				"eslint",
				"dockerls",
				"docker_compose_language_service",
				"gopls",
				"graphql",
				"marksman",
				"asm_lsp",
				"sqlls",
				"yamlls",
				"zls",
				"vimls",
				"elixirls",
				"jinja_lsp",
				"ast_grep",
				"elixirls",
				"rnix",
				"intelephense",
				"harper_ls",
				"jedi_language_server",
			},
		})

		-- Install additional tools with mason-tool-installer
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"pylint",
				"eslint_d",
				"shellharden",
                "shfmt",
			},
		})
	end,
}
