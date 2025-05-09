-- for convenience
local api = vim.api
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local hl = vim.hl
local o = vim.o
local opt_local = vim.opt_local
local uv = vim.uv

-- create nvim autocommand group
local augroup = function (name)
    return api.nvim_create_augroup(
        "akileshas_" .. name,
        { clear = true }
    )
end

-- auto create dir when saving a file, in case some intermediate directory does not exist
api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function (event)
        if event.match:match("^%w%w+:[\\/][\\/]") then
            return
        end

        local file = uv.fs_realpath(event.match) or event.match

        fn.mkdir(fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- check if we need to reload the file when it changed
api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function ()
        if o.buftype ~= "nofile" then
            cmd("checktime")
        end
    end,
})

-- highlight on yank
api.nvim_create_autocmd({ "TextYankPost" }, {
    group = augroup("highlight_yank"),
    callback = function ()
        hl.on_yank({
            timeout = 300,
        })
    end,
})

-- resize splits if window got resized
api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function ()
        local current_tab = fn.tabpagenr()

        cmd("tabdo wincmd =")
        cmd("tabnext " .. current_tab)
    end,
})

-- set filetype for man pages
api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("man"),
    pattern = { "man" },
    callback = function ()
        bo.filetype = "man"
    end,
})

-- make it easier to close man-files when opened inline
api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("man_unlisted"),
    pattern = { "man" },
    callback = function (event)
        bo[event.buf].buflisted = false
    end,
})

-- check for spell in text filetypes
api.nvim_create_autocmd({ "FileType" }, {
    group = augroup("spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function ()
        opt_local.spell = true
    end,
})

-- strip trailing spaces before write
api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("strip_space_and_retab"),
    pattern = { "*" },
    callback = function ()
        if bo.filetype ~= "oil" then
            cmd([[%s/\s\+$//e]])
            cmd("retab")
        end
    end,
})

return {}
