local M = {}

local fn = vim.fn
local api = vim.api
local home = fn.expand("~")
local base_dir = home .. "/repos/algoX"
local tmpl_path = home .. "/.dotfiles/nvim.old/templates/basics.cpp"
local input_file = base_dir .. "/input.txt"
local output_file = base_dir .. "/output.txt"

-- Ensure directory exists
local function ensure_dir(path)
    if fn.isdirectory(path) == 0 then
        fn.mkdir(path, "p")
    end
end

-- Copy template into dated folder and open
function M.copy_cpp_basic_template()
    if fn.filereadable(tmpl_path) == 0 then
        api.nvim_err_writeln("Template not found: " .. tmpl_path)
        return
    end

    local date = os.date("%Y-%m-%d")
    local target_dir = string.format("%s/cf/%s", base_dir, date)
    ensure_dir(target_dir)

    local idx = 1
    local target_file = string.format("%s/%d.cpp", target_dir, idx)
    while fn.filereadable(target_file) == 1 do
        idx = idx + 1
        target_file = string.format("%s/%d.cpp", target_dir, idx)
    end

    fn.writefile(fn.readfile(tmpl_path), target_file)
    api.nvim_command("edit " .. fn.fnameescape(target_file))
end

-- Compile and run current buffer synchronously
function M.compile_run_cpp_file()
    if vim.bo.filetype ~= "cpp" then
        vim.notify("Not a C++ file", vim.log.levels.WARN)
        return
    end
    if not fn.getcwd():find("algoX") then
        vim.notify("Use inside algoX project", vim.log.levels.WARN)
        return
    end

    -- save file and compile
    api.nvim_command("write")
    local src = fn.expand("%:p")
    local bin = fn.expand("%:t:r")
    local compile_cmd = string.format(
        "g++ -O2 -std=c++17 -DLOCAL %s -o %s",
        fn.shellescape(src), fn.shellescape(bin)
    )
    local compile_out = fn.system(compile_cmd)

    if fn.filereadable(bin) == 1 then
        -- run and capture output
        ensure_dir(base_dir)
        local run_cmd = string.format(
            "./%s < %s > %s 2>&1",
            fn.shellescape(bin), fn.shellescape(input_file), fn.shellescape(output_file)
        )
        fn.system(run_cmd)
        os.remove(bin)

        -- refresh the buffer if output is already open, otherwise leave it
        api.nvim_command("checktime " .. fn.fnameescape(output_file))
    else
        api.nvim_err_writeln("Compilation failed:\n" .. compile_out)
    end
end

-- Toggle input/output windows
function M.toggle_input_output()
    local wins = {}
    for _, win in ipairs(api.nvim_list_wins()) do
        local name = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
        if name == input_file or name == output_file then
            table.insert(wins, win)
        end
    end
    if #wins > 0 then
        for _, w in ipairs(wins) do api.nvim_win_close(w, true) end
    else
        ensure_dir(base_dir)
        api.nvim_command("vsplit " .. fn.fnameescape(input_file))
        api.nvim_command("split " .. fn.fnameescape(output_file))
        api.nvim_command("wincmd h")
    end
end

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>cp", M.copy_cpp_basic_template, { desc = "Copy C++ template" })
map("n", "<leader>cc", M.compile_run_cpp_file, { desc = "Compile & run C++" })
map("n", "<leader>sp", M.toggle_input_output, { desc = "Toggle in/out" })

return M
