local api = vim.api -- for convenience

-- Automatically set the filetype for man pages
api.nvim_create_autocmd("FileType", {
  pattern = "man",
  command = "setlocal filetype=man",
})

-- Highlight yanked text
api.nvim_create_autocmd('textyankpost', {
  desc = 'highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

