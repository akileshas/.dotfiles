-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local highlight = vim.hl

-- create nvim autocommand group
local augroup = function(name)
    return api.nvim_create_augroup(
        "akileshas_" .. name,
        { clear = true }
    )
end

-- check if we need to reload the file when it changed
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

-- highlight on yank
api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("highlight_yank"),
    callback = function()
        highlight.on_yank({
            timeout = 300,
        })
    end,
})

-- set filetype for man pages
api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("man"),
    pattern = { "man" },
    command = "setlocal filetype=man",
})

-- strip trailing spaces before write
api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("strip_space_and_retab"),
    pattern = { "*" },
    callback = function()
        if bo.filetype ~= "oil" then
            cmd([[%s/\s\+$//e]])
            cmd("retab")
        end
    end
})

return {}
