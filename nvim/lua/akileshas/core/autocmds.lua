local api = vim.api -- for convenience

-- Automatically set the filetype for man pages
api.nvim_create_autocmd("FileType", {
  pattern = "man",
  command = "setlocal filetype=man",
})
