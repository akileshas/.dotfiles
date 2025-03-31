return {
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason_tool_installer = require("mason-tool-installer")

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
				"autopep8",
				"rustfmt",
				"golines",
				"goimports",
				"gofumpt",
				"ormolu",
				"hlint",
				"haskell-debug-adapter",
			},
		})
	end,
}
