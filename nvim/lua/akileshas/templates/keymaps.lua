-- Importing the required modules
local modules = require("akileshas.templates.modules.cpp.functions")

local keymaps = vim.keymap -- for convenience

-- Define the keymaps

-- Copy the C++ template to a new file
keymaps.set("n", "<leader>cp", modules.copy_cpp_basic_template, {
	desc = "Copy the C++ template to a new file",
})

-- Compile and run the C++ file
keymaps.set("n", "<leader>cr", modules.compile_run_cpp_file, {
	desc = "Compile and run the C++ file",
})

-- Opening the input.txt and output.txt files
keymaps.set("n", "<leader>sp", modules.open_input_output_files, {
	desc = "Open the input.txt and output.txt files",
})
