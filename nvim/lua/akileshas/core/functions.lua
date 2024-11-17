local M = {}

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd

function M.toggle_command_line()
	if fn.getcmdwintype() == ":" then
		-- Close the command-line window
		cmd("quit")
	else
		-- Open the command-line window
		api.nvim_feedkeys(api.nvim_replace_termcodes(":<C-f>", true, true, true), "n", true)
	end
end

function M.open_file_default_program()
	local filename = fn.expand("%:p") -- Get the full path of the current file
	local ext = fn.fnamemodify(filename, ":e") -- Get the file extension

	-- List of allowed file extensions for images and PDFs
	local allowed_exts = { "jpg", "jpeg", "png", "gif", "bmp", "pdf", "tiff", "webp" }

	-- Check if the extension is in the list of allowed extensions
	if vim.tbl_contains(allowed_exts, ext) then
		cmd("!xdg-open " .. filename) -- Open the file with xdg-open
	else
		print("Not an image or PDF file!") -- Optional: feedback when it's not an image or PDF
	end
end

return M