return {
	{
		"echasnovski/mini.ai",
		config = function()
			require("mini.ai").setup({ n_lines = 10000 })
		end,
	},
	{
		"echasnovski/mini.comment",
		config = function()
			require("mini.comment").setup()
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
			require("mini.splitjoin").setup({ mappings = { toggle = "sj" } })
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			require("mini.surround").setup()
		end,
	},
	-- {
	-- 	"echasnovski/mini.starter",
	-- 	config = function()
	-- 		require("mini.starter").setup()
	-- 	end,
	-- },
}
