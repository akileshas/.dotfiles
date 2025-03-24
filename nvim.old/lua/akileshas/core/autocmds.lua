local api = vim.api
local cmd = vim.cmd
local highlight = vim.highlight

-- highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
			on_visual = true,
		})
	end,
})
