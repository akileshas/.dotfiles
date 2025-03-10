-- for convenience
local api = vim.api
local cmd = vim.cmd
local highlight = vim.highlight

-- set filetype for man pages
api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "setlocal filetype=man",
})

-- highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		highlight.on_yank({
			timeout = 300,
			on_visual = true,
		})
	end,
})

return {}
