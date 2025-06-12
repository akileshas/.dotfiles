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

    local devicons = require("nvim-web-devicons")
    local utils = require("akileshas.utils")

    local tabinfo = function (tabnr)
        local buflist = fn.tabpagebuflist(tabnr)
        local winnr = fn.tabpagewinnr(tabnr)
        local bufnr = buflist[winnr]
        local bufname = fn.bufname(bufnr)
        local name = fn.fnamemodify(bufname, ":t")
        local filetype = bo[bufnr].filetype
        local buftype = bo[bufnr].buftype
        local modified = bo[bufnr].modified

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
        elseif buftype == "nofile" then
            name = filetype
        elseif name == "" then
            name = buftype ~= "" and buftype or filetype
        end

        return {
            name = name,
            filetype = filetype,
            modified = modified,
        }
    end

    local tablabel = function (tabnr)
        local info = tabinfo(tabnr)
        local name = info.name
        local filetype = info.filetype
        local modified = info.modified
        local is_current = (tabnr == fn.tabpagenr())

        local suffix = is_current and "*" or (tabnr == previous_tabnr and "-" or "")
        local count_str = ""

        if name_counts[name] then
            local seen = 0

            for tab = 1, tabnr do
                if tab_bufnames[tab] == name then
                    seen = seen + 1
                end
            end

            count_str = string.format("(%d)", seen)
        end

        local icon = devicons.get_icon_by_filetype(info.filetype) or ({
            prompt = "",
            dashboard = "󰕮",
            notification = "󰍡",
            oil = "",
            new = "",
            scratch = "",
            term = "",
            help = "󰋖",
        })[name] or ""

        local hl_group = is_current
            and (modified and "TabLineModifiedActive" or "TabLineActive")
            or (modified and "TabLineModifiedInactive" or "TabLineInactive")

        return string.format(
            "%%@v:lua.to_tab_%d@%%#%s# %s [%s]%s%s %%T",
            tabnr,
            hl_group,
            icon,
            name,
            count_str,
            suffix
        )
    end

    for tabnr = 1, fn.tabpagenr("$") do
        local info = tabinfo(tabnr)
        local name = info.name

        tab_bufnames[tabnr] = name
        name_counts[name] = (name_counts[name] or 0) + 1
    end

    for tabnr = 1, fn.tabpagenr("$") do
        _G["to_tab_" .. tabnr] = function ()
            cmd("tabnext " .. tabnr)
        end

        tabline = tabline .. tablabel(tabnr)
    end

    tabline = tabline .. "%#TabLineFill#%T"

    -- custom highlight group
    local highlights = {
        {
            name = "TabLineSel",
            val = {
                bg = "#3B4261",
                fg = "#C0CAF5",
            },
        },
        {
            name = "TabLine",
            val = {
                bg = "#16161E",
                fg = "#C0CAF5",
            },
        },
        {
            name = "TabLineFill",
            val = {
                bg = "#15161E",
            },
        },
        {
            name = "TabLineActive",
            val = {
                bg = "#3B4261",
                fg = "#C0CAF5",
            },
        },
        {
            name = "TabLineInactive",
            val = {
                bg = "#16161E",
                fg = "#C0CAF5",
            },
        },
        {
            name = "TabLineModifiedActive",
            val = {
                bg = "#3B4261",
                fg = "#E0AF68",
            },
        },
        {
            name = "TabLineModifiedInactive",
            val = {
                bg = "#16161E",
                fg = "#E0AF68",
            },
        },
    }

    utils.set_hls(highlights)

    -- track previous tab
    api.nvim_create_autocmd({ "TabLeave" }, {
        group = utils.reset_augroup("update_previous_tabnr"),
        callback = function ()
            previous_tabnr = fn.tabpagenr()
        end,
    })

    return tabline
end

return M
