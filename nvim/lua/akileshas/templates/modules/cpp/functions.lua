local M = {}

-- Copy the C++ template to a new file
function M.copy_cpp_basic_template()
	-- Define the source and target directories
	local source_file = vim.fn.expand("/home/akileshas/.dotfiles/nvim/lua/akileshas/templates/skeletons/cpp/basics.cpp")
	local target_dir = "/home/akileshas/personal/AlgoX/"

	-- for convenience
	local fn = vim.fn
	local api = vim.api
	local cmd = vim.cmd

	-- Check if the source file exists
	if fn.filereadable(source_file) == 0 then
		api.nvim_err_writeln("Source file not found: " .. source_file)
		return
	end

	-- Get today's date
	local date = os.date("%Y-%m-%d")

	-- Create the target directory if it doesn't exist
	fn.mkdir(target_dir .. date, "p")

	-- Find the next available count
	local count = 1
	while fn.filereadable(target_dir .. date .. "/" .. count .. ".cpp") == 1 do
		count = count + 1
	end

	-- Define the target file path
	local target_file = target_dir .. date .. "/" .. count .. ".cpp"

	-- Read the contents of the source file
	local source_content = table.concat(vim.fn.readfile(source_file), "\n")

	-- Write the content to the target file
	local target_file_handle = io.open(target_file, "w")
	if not target_file_handle then
		api.nvim_err_writeln("Failed to open target file: " .. target_file)
		return
	end
	target_file_handle:write(source_content)
	target_file_handle:close()

	-- Open the new file in Neovim
	cmd("edit " .. target_file)
end

-- Compile and run the C++ file
function M.compile_run_cpp_file()
	-- Check file type
	local filetype = vim.bo.filetype
	local fn = vim.fn
	local cmd = vim.cmd
	local api = vim.api

	if filetype == "cpp" then
		-- Save the file
		cmd("w")

		-- Define the output binary name
		local output_name = fn.expand("%:t:r")

		-- Compile the C++ file
		cmd("!g++ -DLOCAL -o " .. output_name .. " % 2> /home/akileshas/personal/AlgoX/compiler_error.txt")

		-- Check if the compilation was successful
		local compile_status = fn.system("echo $?")
		if compile_status:match("0") then
			-- Run the compiled binary
			cmd("!./" .. output_name)

			-- Remove the compiled binary
			cmd("!rm " .. output_name)
		else
			-- Print compile errors
			cmd("!cat /home/akileshas/personal/AlgoX/compiler_error.txt")
			api.nvim_err_writeln("Compilation failed. Check compiler_error.txt for details.")
		end
	end
end

-- Opening the input.txt and output.txt files
function M.open_input_output_files()
	-- for convenience
	local cmd = vim.cmd

	cmd("vsplit /home/akileshas/personal/AlgoX/input.txt")
	cmd("split /home/akileshas/personal/AlgoX/output.txt")
	cmd("split /home/akileshas/personal/AlgoX/compiler_error.txt")
end

return M
