-- for convenience
local api = vim.api

-- set filetype for man pages
api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "setlocal filetype=man",
})

return {}
