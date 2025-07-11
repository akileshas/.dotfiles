local M = {}

-- Copy the C++ template to a new file
function M.copy_cpp_basic_template()
    -- Define the source and target directories
    local source_file = vim.fn.expand("/home/akileshas/.dotfiles/nvim.old/templates/basics.cpp")
    local target_dir = "/home/akileshas/repos/algoX/"

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
    local log = vim.log

    -- Check if the current directory contains "AlgoX"
    local cwd = fn.getcwd() -- Get current working directory
    if not cwd:find("algoX") then
        vim.notify("It's for Competative Programming !", log.levels.WARN)
        return
    end

    if filetype == "cpp" then
        -- Save the file
        cmd("w")

        -- Define the output binary name
        local output_name = fn.expand("%:t:r")

        -- Compile the C++ file
        local compile_command = "g++ -DLOCAL -o "
            .. fn.shellescape(output_name)
            .. " "
            .. fn.shellescape(fn.expand("%:p"))
            .. " 2> /home/akileshas/repos/algoX/compiler_error.txt"
        local compile_status = fn.system(compile_command)

        -- Check if the compilation was successful
        if fn.filereadable(output_name) == 1 then
            -- Run the compiled binary
            cmd("!./" .. fn.shellescape(output_name))

            -- Remove the compiled binary
            fn.system("rm " .. fn.shellescape(output_name))
        else
            -- Print compile errors
            api.nvim_err_writeln("Compilation failed. Check compiler_error.txt for details.")
        end
    else
        vim.notify("Not a C++ file!", log.levels.WARN)
    end
end

-- Toggle opening/closing input.txt, output.txt, and compiler_error.txt
function M.toggle_input_output_files()
    -- for convenience
    local cmd = vim.cmd
    local api = vim.api

    -- Check if any of the files are already open in a split
    local is_input_open = false
    local is_output_open = false
    local is_error_open = false
    local input_win_id, output_win_id, error_win_id = nil, nil, nil

    -- Iterate through all open windows and check their buffers
    for _, win_id in ipairs(api.nvim_list_wins()) do
        local buf_id = api.nvim_win_get_buf(win_id)
        local buf_name = api.nvim_buf_get_name(buf_id)
        if buf_name == "/home/akileshas/repos/algoX/input.txt" then
            is_input_open = true
            input_win_id = win_id
        elseif buf_name == "/home/akileshas/repos/algoX/output.txt" then
            is_output_open = true
            output_win_id = win_id
        elseif buf_name == "/home/akileshas/repos/algoX/compiler_error.txt" then
            is_error_open = true
            error_win_id = win_id
        end
    end

    -- If any file is open, close those windows
    if is_input_open then
        api.nvim_win_close(input_win_id, true)
    end
    if is_output_open then
        api.nvim_win_close(output_win_id, true)
    end
    if is_error_open then
        api.nvim_win_close(error_win_id, true)
    end

    -- If none of the files are open, open the splits
    if not (is_input_open or is_output_open or is_error_open) then
        cmd("vsplit /home/akileshas/repos/algoX/input.txt")
        cmd("split /home/akileshas/repos/algoX/output.txt")
        cmd("split /home/akileshas/repos/algoX/compiler_error.txt")
        cmd("wincmd h")
    end
end


local keymaps = vim.keymap -- for convenience

-- Define the keymaps

-- Copy the C++ template to a new file
keymaps.set("n", "<leader>cp", M.copy_cpp_basic_template, {
    desc = "Copy the C++ template to a new file",
})

-- Compile and run the C++ file
keymaps.set("n", "<leader>cc", M.compile_run_cpp_file, {
    desc = "Compile and run the C++ file",
})

-- Opening the input.txt and output.txt files
keymaps.set("n", "<leader>sp", M.toggle_input_output_files, {
    desc = "Open the input.txt and output.txt files",
})
