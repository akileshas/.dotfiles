local api = vim.api
local cmd = vim.cmd
local highlight = vim.highlight

-- Automatically set the filetype for man pages
api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "setlocal filetype=man",
})

-- Highlight yanked text
api.nvim_create_autocmd("textyankpost", {
	desc = "highlight when yanking text",
	group = api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
			on_visual = true,
		})
	end,
})
