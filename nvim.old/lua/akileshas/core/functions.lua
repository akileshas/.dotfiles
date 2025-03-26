local M = {}

-- for convenience
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local bo = vim.bo
local notify = vim.notify
local log = vim.log
local loop = vim.loop

function M.open_file_default_program()
	local filename = fn.expand("%:p") -- Get the full path of the current file
	local ext = fn.fnamemodify(filename, ":e") -- Get the file extension

	-- List of allowed file extensions for images and PDFs
	local allowed_exts = { "jpg", "jpeg", "png", "gif", "bmp", "pdf", "tiff", "webp" }

	-- Check if the extension is in the list of allowed extensions
	if vim.tbl_contains(allowed_exts, ext) then
		-- Use xdg-open for Linux, open for macOS, and start for Windows
		local open_cmd = loop.os_uname().sysname == "Windows_NT" and "start"
			or (loop.os_uname().sysname == "Darwin" and "open" or "xdg-open")
		cmd("!" .. open_cmd .. " " .. fn.shellescape(filename))
	else
		notify("Not an image or PDF file!", log.levels.WARN)
	end
end

function M.run_python_script()
	-- Only save the file if it's not a terminal buffer
	if bo.buftype ~= "terminal" then
		cmd("w") -- Save the current file
	end

	local filetype = bo.filetype -- Get the filetype of the current file

	-- Check if the filetype is Python
	if filetype ~= "python" then
		notify("Not a Python file!", log.levels.WARN)
		return
	end

	local filename = fn.shellescape(fn.expand("%")) -- Get the full path of the current file

	-- Check if a terminal split is already open
	local terminal_open = false
	local terminal_win_id = nil

	-- Iterate through all open windows and check if any of them are terminals
	for _, win_id in ipairs(api.nvim_list_wins()) do
		local buf_id = api.nvim_win_get_buf(win_id)
		local buf_name = api.nvim_buf_get_name(buf_id)
		if buf_name:match("term://") then
			terminal_open = true
			terminal_win_id = win_id
			break
		end
	end

	-- If a terminal is open, close it (only if terminal_win_id is not nil)
	if terminal_open and terminal_win_id ~= nil then
		api.nvim_win_close(terminal_win_id, true)
	end

	-- Open a new terminal split and run the Python script
	cmd("split | terminal python3 " .. filename)
end

function M.run_c_cpp_script()
	-- Only save the file if it's not a terminal buffer
	if bo.buftype ~= "terminal" then
		cmd("w") -- Save the current file
	end

	local ext = fn.expand("%:e") -- Get the file extension

	-- Check if the file is C or C++
	if ext ~= "c" and ext ~= "cpp" then
		notify("Not a C or C++ file!", log.levels.WARN)
		return
	end

	local filename = fn.shellescape(fn.expand("%")) -- Get the full path of the current file

	-- Check if a terminal split is already open
	local terminal_open = false
	local terminal_win_id = nil

	-- Iterate through all open windows and check if any of them are terminals
	for _, win_id in ipairs(api.nvim_list_wins()) do
		local buf_id = api.nvim_win_get_buf(win_id)
		local buf_name = api.nvim_buf_get_name(buf_id)
		if buf_name:match("term://") then
			terminal_open = true
			terminal_win_id = win_id
			break
		end
	end

	-- If a terminal is open, close it (only if terminal_win_id is not nil)
	if terminal_open and terminal_win_id ~= nil then
		api.nvim_win_close(terminal_win_id, true)
	end

	-- Compile and run the C/C++ file in a new terminal split
	local term_cmd = ""
	if ext == "c" then
		term_cmd = "gcc " .. filename .. " -o output && ./output"
	elseif ext == "cpp" then
		term_cmd = "g++ " .. filename .. " -o output && ./output"
	end

	-- Notify the user
	notify("Compiling and running the C/C++ file...", log.levels.INFO)
	cmd("split | terminal " .. term_cmd)

	-- Remove the compiled binary after running it
	cmd("autocmd BufWipeout * silent! !rm -f output")
end

function M.copy_whole_file_to_system_clipboard()
	-- Copy the whole buffer to the system clipboard
	fn.setreg("+", fn.getline("1", "$"))
	-- Notify the user
	notify("Copied the whole buffer to the system clipboard!", log.levels.INFO)
end

return M
