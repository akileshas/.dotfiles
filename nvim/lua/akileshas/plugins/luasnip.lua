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

-- plugin dependencies
local dependencies = {
	{
		"rafamadriz/friendly-snippets",
	},
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	history = true,
	enable_autosnippets = true,
	update_events = {
		"TextChanged",
		"TextChangedI",
	},
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local ls = require("luasnip")

	if opts == nil then
		opts = {}
	end

	-- configure luasnip
	ls.config.setup(opts)

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

-- plugin keys
local keys = {
	{
		"<leader>ls",
		mode = { "n" },
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
	version = "*",
	enabled = true,
	lazy = true,
	event = {},
	cmd = {},
	ft = {},
	build = {
		"make install_jsregexp",
	},
	dependencies = dependencies,
	init = init,
	opts = opts,
	config = config,
	keys = keys,
}
