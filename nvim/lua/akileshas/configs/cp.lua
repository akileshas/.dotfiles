local M = {}

-- Aliases
local fn = vim.fn
local api = vim.api
local cmd = vim.cmd
local notify = vim.notify

-- Constants
local home = fn.expand("~")
local base_dir = home .. "/repos/algoX"
local tmpl_path = home .. "/.dotfiles/nvim.old/templates/basics.cpp"
local input_file = base_dir .. "/input.txt"
local output_file = base_dir .. "/output.txt"

-- Create directory if it doesn't exist
local function ensure_dir(path)
    if fn.isdirectory(path) == 0 then fn.mkdir(path, "p") end
end

-- Copy template C++ file to new dated dir with incrementing filename
function M.copy_cpp_basic_template()
    if fn.filereadable(tmpl_path) == 0 then
        api.nvim_err_writeln("Missing template: " .. tmpl_path)
        return
    end

    local date = os.date("%Y-%m-%d")
    local target_dir = base_dir .. "/cf/" .. date
    ensure_dir(target_dir)

    local idx = 1
    local target_file = string.format("%s/%d.cpp", target_dir, idx)
    while fn.filereadable(target_file) == 1 do
        idx = idx + 1
        target_file = string.format("%s/%d.cpp", target_dir, idx)
    end

    fn.writefile(fn.readfile(tmpl_path), target_file)
    cmd.edit(fn.fnameescape(target_file))
end

-- Compile and run the current buffer
function M.compile_run_cpp_file()
    if vim.bo.filetype ~= "cpp" then
        notify("Not a C++ file", vim.log.levels.WARN)
        return
    end
    if not fn.getcwd():find("algoX", 1, true) then
        notify("Use inside algoX project", vim.log.levels.WARN)
        return
    end

    cmd.write()
    local src = fn.expand("%:p")
    local bin = fn.expand("%:t:r")

    local compile_cmd = ("g++ -O2 -std=c++17 -DLOCAL %s -o %s"):format(
        fn.shellescape(src), fn.shellescape(bin)
    )
    local compile_out = fn.system(compile_cmd)

    if fn.filereadable(bin) == 1 then
        ensure_dir(base_dir)
        local run_cmd = ("./%s < %s > %s 2>&1"):format(
            fn.shellescape(bin), fn.shellescape(input_file), fn.shellescape(output_file)
        )
        fn.system(run_cmd)
        os.remove(bin)

        cmd.checktime(fn.fnameescape(output_file))
    else
        api.nvim_err_writeln("Compilation failed:\n" .. compile_out)
    end
end

-- Toggle input/output file windows
function M.toggle_input_output()
    if vim.bo.filetype ~= "cpp" then
        notify("Not a C++ file", vim.log.levels.WARN)
        return
    end
    if not fn.getcwd():find("algoX", 1, true) then
        notify("Use inside algoX project", vim.log.levels.WARN)
        return
    end

    local open_wins = {}
    for _, win in ipairs(api.nvim_list_wins()) do
        local name = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
        if name == input_file or name == output_file then
            table.insert(open_wins, win)
        end
    end

    if #open_wins > 0 then
        for _, win in ipairs(open_wins) do
            api.nvim_win_close(win, true)
        end
    else
        ensure_dir(base_dir)
        cmd.vsplit(fn.fnameescape(input_file))
        cmd.split(fn.fnameescape(output_file))
        cmd.wincmd("h")
    end
end

-- Keybindings
local map = vim.keymap.set

map("n", "<leader>cp", M.copy_cpp_basic_template, { desc = "Copy C++ template" })
map("n", "<leader>cc", M.compile_run_cpp_file, { desc = "Compile & run C++" })
map("n", "<leader>sp", M.toggle_input_output, { desc = "Toggle input/output windows" })
