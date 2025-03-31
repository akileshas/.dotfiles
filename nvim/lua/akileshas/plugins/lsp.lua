-- for convenience
local api = vim.api
local cmd = vim.cmd
local diagnostic = vim.diagnostic
local fn = vim.fn
local keymap = vim.keymap
local lsp = vim.lsp

-- plugin dependencies
local dependencies = {
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
}

-- diagnostics signs
local signs = {
	ERROR = " ",
	WARN = " ",
	HINT = "󰠠 ",
	INFO = " "
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	diagnostics = {
		underline = false,
		update_in_insert = true,
		virtual_text = false,
		severity_sort = true,
		signs = {
			text = {
				[diagnostic.severity.ERROR] = signs.ERROR,
				[diagnostic.severity.WARN] = signs.WARN,
				[diagnostic.severity.HINT] = signs.HINT,
				[diagnostic.severity.INFO] = signs.INFO,
			},
		},
	},
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")
	local blink_cmp = require("blink.cmp")

	local default_setup = function(server_name)
		local default_lsp_config = {
			capabilities = blink_cmp.get_lsp_capabilities()
		}

		lspconfig[server_name].setup(default_lsp_config)
	end

	if opts == nil then
		opts = {}
	end

	-- configure diagnostics
	diagnostic.config(opts.diagnostics)

	-- automatically setup each server installed by mason
	local handlers = {
		default_setup
	}
	mason_lspconfig.setup_handlers(handlers)
end

-- plugin keys
local keys = {}

-- plugin configurations
return {
	"neovim/nvim-lspconfig",
	version = "*",
	enabled = true,
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	config = config,
	keys = keys,
}
