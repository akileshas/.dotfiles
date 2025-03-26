-- for convenience
local api = vim.api
local highlight = vim.highlight
local cmd = vim.cmd
local loop = vim.loop

-- create nvim autocommand group
local function augroup(name)
	return api.nvim_create_augroup(
		'akileshas_' .. name,
		{ clear = true }
	)
end

-- set filetype for man pages
api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("man"),
	pattern = { "man" },
	command = "setlocal filetype=man",
})

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

-- strip trailing spaces before write
api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = augroup('strip_space'),
	pattern = { '*' },
	callback = function()
		cmd([[ %s/\s\+$//e ]])
	end
})

-- check if we need to reload the file when it changed
api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
	group = augroup('checktime'),
	command = 'checktime',
})

-- highlight on yank
api.nvim_create_autocmd({ "TextYankPost" }, {
	group = augroup("highlight_yank"),
	callback = function()
		highlight.on_yank({
			timeout = 300,
		})
	end,
})

return {}
