-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------- General Keymaps -----------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- increment/decrement of window width and height
keymap.set("n", "<C-Right>", [[<cmd>vertical resize +5<cr>]]) -- make the window bigger vertically
keymap.set("n", "<C-Left>", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically
keymap.set("n", "<C-Up>", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally
keymap.set("n", "<C-Down>", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally

----------- Custom keymaps for competitive programming -----------

-- Copy the C++ template to a new file
local function copy_cpp_template()
  -- Define the source and target directories
  local source_file = vim.fn.expand("~/.dotfiles/nvim/lua/asa/skeletons/cpp_template.cpp")
  local target_dir = "/home/asa/Codes/DSA/"

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

-- Set the keymap to call the function
vim.keymap.set("n", "<leader>cp", copy_cpp_template)

-- Set the keymap for compiling and running C++ code
vim.keymap.set("n", "<leader>cc", function()
  -- Check file type
  local filetype = vim.bo.filetype
  if filetype == "cpp" then
    -- Save the file
    vim.cmd("w")

    -- Define the output binary name
    local output_name = vim.fn.expand("%:t:r")

    -- Compile the C++ file
    vim.cmd("!g++ -DLOCAL -o " .. output_name .. " % 2> compile_errors.txt")

    -- Check if the compilation was successful
    local compile_status = vim.fn.system("echo $?")
    if compile_status:match("0") then
      -- Run the compiled binary
      vim.cmd("!./" .. output_name)

      -- Remove the compiled binary
      vim.cmd("!rm " .. output_name)
    else
      -- Print compile errors
      vim.cmd("!cat compile_errors.txt")
      vim.api.nvim_err_writeln("Compilation failed. Check compile_errors.txt for details.")
    end
  end
end)

-- Set the keymap for opening input.txt and output.txt
vim.keymap.set("n", "<leader>sp", function()
  vim.cmd("vsplit input.txt")
  vim.cmd("split output.txt")
  vim.cmd("split compile_errors.txt")
end)
