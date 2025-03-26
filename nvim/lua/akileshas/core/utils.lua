-- for convenience
local api = vim.api

-- set filetype for man pages
api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "setlocal filetype=man",
})

-- set the lsp integrated file renaming
api.nvim_create_autocmd("User", {
	pattern = "OilActionsPost",
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(
				event.data.actions.src_url,
				event.data.actions.dest_url
			)
		end
	end,
})

return {}
