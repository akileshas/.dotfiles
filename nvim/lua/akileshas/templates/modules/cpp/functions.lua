local M = {}

-- Copy the C++ template to a new file
function M.copy_cpp_basic_template()
	-- Define the source and target directories
	local source_file = vim.fn.expand("~/.dotfiles/nvim/lua/akileshas/templates/skeletons/cpp/basics.cpp")
	local target_dir = "/home/asa/Personal/DSA/"

	-- Check if the source file exists
	if vim.fn.filereadable(source_file) == 0 then
		vim.api.nvim_err_writeln("Source file not found: " .. source_file)
		return
	end

	-- Get today's date
	local date = os.date("%Y-%m-%d")

	-- Create the target directory if it doesn't exist
	vim.fn.mkdir(target_dir .. date, "p")

	-- Find the next available count
	local count = 1
	while vim.fn.filereadable(target_dir .. date .. "/" .. count .. ".cpp") == 1 do
		count = count + 1
	end

	-- Define the target file path
	local target_file = target_dir .. date .. "/" .. count .. ".cpp"

	-- Read the contents of the source file
	local source_content = table.concat(vim.fn.readfile(source_file), "\n")

	-- Write the content to the target file
	local target_file_handle = io.open(target_file, "w")
	if not target_file_handle then
		vim.api.nvim_err_writeln("Failed to open target file: " .. target_file)
		return
	end
	target_file_handle:write(source_content)
	target_file_handle:close()

	-- Open the new file in Neovim
	vim.cmd("edit " .. target_file)
end

-- Compile and run the C++ file
function M.compile_run_cpp_file()
	-- Check file type
	local filetype = vim.bo.filetype
	if filetype == "cpp" then
		-- Save the file
		vim.cmd("w")

		-- Define the output binary name
		local output_name = vim.fn.expand("%:t:r")

		-- Compile the C++ file
		vim.cmd("!g++ -DLOCAL -o " .. output_name .. " % 2> ~/Personal/DSA/compile_errors.txt")

		-- Check if the compilation was successful
		local compile_status = vim.fn.system("echo $?")
		if compile_status:match("0") then
			-- Run the compiled binary
			vim.cmd("!./" .. output_name)

			-- Remove the compiled binary
			vim.cmd("!rm " .. output_name)
		else
			-- Print compile errors
			vim.cmd("!cat ~/Personal/DSA/compile_errors.txt")
			vim.api.nvim_err_writeln("Compilation failed. Check compile_errors.txt for details.")
		end
	end
end

-- Opening the input.txt and output.txt files
function M.open_input_output_files()
	vim.cmd("vsplit ~/Personal/DSA/input.txt")
	vim.cmd("split ~/Personal/DSA/output.txt")
	vim.cmd("split ~/Personal/DSA/compile_errors.txt")
end

return M
