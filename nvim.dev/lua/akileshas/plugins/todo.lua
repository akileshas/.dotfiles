-- plugin options
local options = {}

-- plugin keymaps
local keymaps = {
	{
		"<leader>st",
		mode = "n",
		function()
			Snacks.picker.todo_comments()
		end,
		noremap = true,
		silent = true,
		desc = "search for todo comments",
	},
}

-- plugin configurations
return {
	"folke/todo-comments.nvim",
	lazy = true,
	opts = options,
	keys = keymaps,
}
