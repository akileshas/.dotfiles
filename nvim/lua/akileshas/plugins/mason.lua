-- list of lsp servers to be installed
local ensure_installed = {
	"lua_ls",
}

-- plugin dependencies
local dependencies = {
	{
		"saghen/blink.cmp",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	ui = {
		check_outdated_packages_on_open = true,
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")

	if opts == nil then
		opts = {}
	end

	-- configure mason
	mason.setup(opts)

	-- configure mason-lspconfig
	mason_lspconfig.setup({
		ensure_installed = ensure_installed,
		automatic_installation = true,
	})
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"williamboman/mason.nvim",
	version = "*",
	enabled = true,
	lazy = true,
	event = {},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	config = config,
	keys = keys,
}
