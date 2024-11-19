return {
	{
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup({ n_lines = 10000 })
		end,
	},
	{
		"echasnovski/mini.animate",
		config = function()
			require("mini.animate").setup()
		end,
	},
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
		end,
	},
	{
		"echasnovski/mini.indentscope",
		config = function()
			require("mini.indentscope").setup()
		end,
	},
	{
		"echasnovski/mini.jump",
		config = function()
			require("mini.jump").setup()
		end,
	},
	{
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.splitjoin",
		config = function()
			require("mini.splitjoin").setup({ mappings = { toogle = "<Leader>sj" } })
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},
}
