-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local hl = vim.hl
local o = vim.o

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
    callback = function()
        if o.buftype ~= "nofile" then
            cmd("checktime")
        end
    end,
})

-- highlight on yank
api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("highlight_yank"),
    callback = function()
        hl.on_yank({
            timeout = 300,
        })
    end,
})

-- resize splits if window got resized
api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = fn.tabpagenr()

        cmd("tabdo wincmd =")
        cmd("tabnext " .. current_tab)
    end,
})

-- set filetype for man pages
api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("man"),
    pattern = { "man" },
    callback = function()
        bo.filetype = "man"
    end,
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
