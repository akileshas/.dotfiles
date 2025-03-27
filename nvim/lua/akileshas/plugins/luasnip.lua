-- custom snip_info
local snip_info = function(snippet)
	return {
		name = snippet.name,
		trigger = snippet.trigger,
		docstring = snippet.docstring,
		description = snippet.description,
		regTrig = snippet.regTrig,
		wordTrig = snippet.wordTrig,
	}
end

-- for convenience
local fn = vim.fn

-- plugin dependencies
local dependencies = {
	"rafamadriz/friendly-snippets",
}

-- plugin options
local options = {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
}

-- plugin config function
local config =  function(_, opts)
	-- for convenience
	local ls = require("luasnip")

	if opts then
		ls.config.setup(opts)
	end

	-- dynamically load snippet formats
	local snippet_types = {
		"vscode",
		"snipmate",
		"lua"
	}
	for _, type in ipairs(snippet_types) do
		require("luasnip.loaders.from_" .. type).lazy_load()
	end

	-- extend filetypes with standardized comments
	local filetype_extensions = {
		typescript = { "tsdoc" },
		javascript = { "jsdoc" },
		lua = { "luadoc" },
		python = { "pydoc" },
		rust = { "rustdoc" },
		cs = { "csharpdoc" },
		java = { "javadoc" },
		c = { "cdoc" },
		cpp = { "cppdoc" },
		php = { "phpdoc" },
		kotlin = { "kdoc" },
		ruby = { "rdoc", "rails" },
		sh = { "shelldoc" },
	}
	for filetype, extensions in pairs(filetype_extensions) do
		ls.filetype_extend(filetype, extensions)
	end
end

-- plugin keymaps
local keymaps = {
	{
		mode = "n",
		"<leader>ls",
		function()
			require("luasnip.extras.snippet_list").open({
				snip_info = snip_info,
			})
		end,
		noremap = true,
		silent = true,
		desc = "open luasnip snippet list",
	},
}

-- plugin configurations
return {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	lazy = true,
	dependencies = dependencies,
	opts = options,
	config = config,
	keys = keymaps,
}
