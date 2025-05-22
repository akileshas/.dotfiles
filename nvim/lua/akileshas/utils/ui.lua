-- for convenience
local api = vim.api
local b = vim.b
local bo = vim.bo
local cmd = vim.cmd
local fn = vim.fn
local treesitter = vim.treesitter
local v = vim.v

local previous_tabnr = 1

local M = {}

M.foldexpr = function ()
    local buf = api.nvim_get_current_buf()

    if b[buf].ts_folds == nil then
        -- as long as we don't have a filetype, don't bother
        -- checking if treesitter is available (it won't)
        if bo[buf].filetype == "" then
            return "0"
        end
        if bo[buf].filetype:find("dashboard") then
            b[buf].ts_folds = false
        else
            b[buf].ts_folds = pcall(treesitter.get_parser, buf)
        end
    end

    return b[buf].ts_folds and treesitter.foldexpr() or "0"
end

M.foldtext = function ()
    local first_line = fn.getline(v.foldstart)
    local folded_lines = v.foldend - v.foldstart + 1

    return "+--- " .. folded_lines .. " lines: " .. first_line .. " ..."
end

M.tabline = function ()
    local tabline = ""

    local name_counts = {}
    local tab_bufnames = {}

    local utils = require("akileshas.utils")

    for tabnr = 1, fn.tabpagenr("$") do
        local buflist = fn.tabpagebuflist(tabnr)
        local winnr = fn.tabpagewinnr(tabnr)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)
        local name = fn.fnamemodify(bufname, ":t")
        local filetype = bo[bufnr].filetype
        local buftype = bo[bufnr].buftype

        if name == "" and filetype == "" and buftype == "" then
            name = "no name"
        elseif name == "bash" and buftype == "terminal" then
            name = "term"
        elseif filetype == "snacks_dashboard" then
            name = "dashboard"
        elseif filetype == "snacks_notif" then
            name = "notification"
        elseif filetype == "oil" then
            name = "oil"
        elseif filetype == "help" then
            name = "help"
        elseif name == "" then
            name = buftype ~= "" and buftype or filetype
        end

        tab_bufnames[tabnr] = name
        name_counts[name] = (name_counts[name] or 0) + 1
    end

    local tablabel = function (tabnr)
        local devicons = require("nvim-web-devicons")

        local buflist = fn.tabpagebuflist(tabnr)
        local winnr = fn.tabpagewinnr(tabnr)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)
        local name = fn.fnamemodify(bufname, ":t")
        local filetype = bo[bufnr].filetype
        local buftype = bo[bufnr].buftype
        local modified = bo[bufnr].modified
        local is_current = (tabnr == fn.tabpagenr())

        if name == "" and filetype == "" and buftype == "" then
            name = "no name"
        elseif name == "bash" and buftype == "terminal" then
            name = "term"
        elseif filetype == "snacks_dashboard" then
            name = "dashboard"
        elseif filetype == "snacks_notif" then
            name = "notification"
        elseif filetype == "oil" then
            name = "oil"
        elseif filetype == "help" then
            name = "help"
        elseif name == "" then
            name = buftype ~= "" and buftype or filetype
        end

        local suffix = ""
        local count_str = ""

        local icon = devicons.get_icon_by_filetype(filetype)

        if tabnr == fn.tabpagenr() then
            suffix = "*"
        elseif tabnr == previous_tabnr then
            suffix = "-"
        end

       if name_counts[name] then
            local seen = 0
            for tab = 1, tabnr do
                if tab_bufnames[tab] == name then
                    seen = seen + 1
                end
            end
            count_str = string.format("(%d)", seen)
        end

        if not icon then
            icon = ({
                prompt = "",
                dashboard = "󰕮",
                notification = "󰍡",
                oil = "",
                new = "",
                scratch = "",
                term = "",
                help = "󰋖",
            })[name] or ""
        end

        local hl_group = is_current
            and (modified and "TabLineModifiedActive" or "TabLineActive")
            or (modified and "TabLineModifiedInactive" or "TabLineInactive")

        return string.format(
            "%%#%s# %s [%s]%s%s ",
            hl_group,
            icon,
            name,
            count_str,
            suffix
        )
    end

    for tabnr = 1, fn.tabpagenr("$") do
        tabline = tabline .. tablabel(tabnr)
    end

    tabline = tabline .. "%#TabLineFill#%T"

    -- custom highlight group
    api.nvim_set_hl(0, "TabLineSel", {
        bg = "#3B4261",
        fg = "#C0CAF5",
    })

    api.nvim_set_hl(0, "TabLine", {
        bg = "#16161E",
        fg = "#C0CAF5",
    })

    api.nvim_set_hl(0, "TabLineFill", {
        bg = "#15161E",
    })

    api.nvim_set_hl(0, "TabLineActive", {
        bg = "#3B4261",
        fg = "#C0CAF5",
    })

    api.nvim_set_hl(0, "TabLineInactive", {
        bg = "#16161E",
        fg = "#C0CAF5",
    })

    api.nvim_set_hl(0, "TabLineModifiedActive", {
        bg = "#3B4261",
        fg = "#E0AF68",
    })

    api.nvim_set_hl(0, "TabLineModifiedInactive", {
        bg = "#16161E",
        fg = "#E0AF68",
    })

    -- custom autocmd
    api.nvim_create_autocmd({ "TabLeave" }, {
        group = utils.reset_augroup("update_previous_tabnr"),
        callback = function ()
            previous_tabnr = fn.tabpagenr()
        end
    })

    return tabline
end

return M
