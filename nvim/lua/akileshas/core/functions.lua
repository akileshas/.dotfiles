local M = {}

local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local bo = vim.bo

function M.toggle_command_line()
	if fn.getcmdwintype() == ":" then
		-- Close the command-line window
		cmd("q")
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
		-- Use xdg-open for Linux, open for macOS, and start for Windows
		local open_cmd = vim.loop.os_uname().sysname == "Windows_NT" and "start"
			or (vim.loop.os_uname().sysname == "Darwin" and "open" or "xdg-open")
		cmd("!" .. open_cmd .. " " .. fn.shellescape(filename))
	else
		vim.notify("Not an image or PDF file!", vim.log.levels.WARN)
	end
end

function M.run_python_script()
	cmd("w") -- Save the current file
	local filetype = bo.filetype -- Get the filetype of the current file

	-- Check if the filetype is Python
	if filetype ~= "python" then
		vim.notify("Not a Python file!", vim.log.levels.WARN)
		return
	end

	local filename = fn.shellescape(fn.expand("%")) -- Get the full path of the current file
	cmd("split | terminal python3 " .. filename) -- Run the Python script
end

return M
