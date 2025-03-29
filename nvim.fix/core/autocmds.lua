-- lsp integrated file renaming
api.nvim_create_autocmd({ "User" }, {
	group = augroup("snacks_rename"),
	pattern = { "OilActionsPost" },
	callback = function(event)
		if event.data.actions.type == "move" then
			Snacks.rename.on_rename_file(
				event.data.actions.src_url,
				event.data.actions.dest_url
			)
		end
	end,
})
