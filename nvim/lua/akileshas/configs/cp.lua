local M = {}

-- Aliases
local fn, api, cmd = vim.fn, vim.api, vim.cmd

-- Paths
local home = fn.expand("~")
local base_dir = home .. "/repos/algoX"
local tmpl_path = home .. "/.dotfiles/nvim.old/templates/basics.cpp"
local input_file = base_dir .. "/input.txt"
local output_file = base_dir .. "/output.txt"

local function ensure_dir(path)
    if fn.isdirectory(path) == 0 then fn.mkdir(path, "p") end
end

-- Create new file from template in dated folder
function M.copy_cpp_basic_template()
    if fn.filereadable(tmpl_path) == 0 then
        fn.writefile({ "Missing template: " .. tmpl_path }, output_file)
        return
    end

    local date = os.date("%Y-%m-%d")
    local target_dir = base_dir .. "/cf/" .. date
    ensure_dir(target_dir)

    local idx, file = 1, nil
    repeat
        file = string.format("%s/%d.cpp", target_dir, idx)
        idx = idx + 1
    until fn.filereadable(file) == 0

    fn.writefile(fn.readfile(tmpl_path), file)
    cmd.edit(fn.fnameescape(file))
end

-- Compile and run the current buffer using C++23
function M.compile_and_run_cpp()
    if vim.bo.filetype ~= "cpp" then
        fn.writefile({ "Not a C++ file" }, output_file)
        return
    end
    if not fn.getcwd():find("algoX", 1, true) then
        fn.writefile({ "Use inside algoX project" }, output_file)
        return
    end

    cmd.write()
    local src = fn.expand("%:p")
    local bin = fn.expand("%:t:r")

    local compile_cmd = ("g++ -O2 -std=c++23 -DLOCAL %s -o %s"):format(
        fn.shellescape(src), fn.shellescape(bin)
    )
    local compile_out = fn.systemlist(compile_cmd)

    if fn.filereadable(bin) == 1 then
        ensure_dir(base_dir)
        local run_cmd = ("./%s < %s > %s 2>&1"):format(
            fn.shellescape(bin), fn.shellescape(input_file), fn.shellescape(output_file)
        )
        fn.system(run_cmd)
        os.remove(bin)
        cmd.checktime(fn.fnameescape(output_file))
    else
        fn.writefile(compile_out, output_file)
        cmd.checktime(fn.fnameescape(output_file))
    end
end

-- Toggle input/output window splits
function M.toggle_input_output()
    if vim.bo.filetype ~= "cpp" or not fn.getcwd():find("algoX", 1, true) then
        return
    end

    local wins = {}
    for _, win in ipairs(api.nvim_list_wins()) do
        local name = api.nvim_buf_get_name(api.nvim_win_get_buf(win))
        if name == input_file or name == output_file then
            table.insert(wins, win)
        end
    end

    if #wins > 0 then
        for _, win in ipairs(wins) do api.nvim_win_close(win, true) end
    else
        ensure_dir(base_dir)
        cmd.vsplit(fn.fnameescape(input_file))
        cmd.split(fn.fnameescape(output_file))
        cmd.wincmd("h")
    end
end

-- Keybindings
vim.keymap.set("n", "<leader>cp", M.copy_cpp_basic_template, { desc = "Copy C++ template" })
vim.keymap.set("n", "<leader>cc", M.compile_and_run_cpp, { desc = "Compile & run C++23" })
vim.keymap.set("n", "<leader>sp", M.toggle_input_output, { desc = "Toggle input/output windows" })

return M
