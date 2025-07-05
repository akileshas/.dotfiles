-- for convenience
local api = vim.api
local bo = vim.bo
local fn = vim.fn
local treesitter = vim.treesitter

local M = {}

M.ai_buffer = function (ai_type)
    local start_line = 1
    local end_line = fn.line("$")

    if ai_type == "i" then
        local first_nonblank = fn.nextnonblank(start_line)
        local last_nonblank = fn.prevnonblank(end_line)

        if first_nonblank == 0 or last_nonblank == 0 then
            return {
                from = {
                    line = start_line,
                    col = 1,
                },
            }
        end

        start_line = first_nonblank
        end_line = last_nonblank
    end

    local to_col = math.max(fn.getline(end_line):len(), 1)

    return {
        from = {
            line = start_line,
            col = 1,
        },
        to = {
            line = end_line,
            col = to_col,
        },
    }
end

M.pairs = function (opts)
    local MiniPairs = require("mini.pairs")

    local open = MiniPairs.open

    MiniPairs.setup(opts)

    MiniPairs.open = function (pair, neigh_pattern)
        if fn.getcmdline() ~= "" then
            return open(pair, neigh_pattern)
        end

        local o = pair:sub(1, 1)
        local c = pair:sub(2, 2)
        local line = api.nvim_get_current_line()
        local cursor = api.nvim_win_get_cursor(0)
        local next = line:sub(cursor[2] + 1, cursor[2] + 1)
        local before = line:sub(1, cursor[2])

        if opts.markdown and o == "`" and bo.filetype == "markdown" and before:match("^%s*``") then
            return "`\n```" .. api.nvim_replace_termcodes("<Up>", true, true, true)
        end

        if opts.python and o == [["]] and bo.filetype == "python" and before:match([[""$]]) then
            return [[""""]] .. api.nvim_replace_termcodes("<Left><Left><Left>", true, true, true)
        end

        if opts.skip_next and next ~= "" and next:match(opts.skip_next) then
            return o
        end

        if opts.skip_ts and #opts.skip_ts > 0 then
            local ok, captures = pcall(
                treesitter.get_captures_at_pos,
                0,
                cursor[1] - 1,
                math.max(cursor[2] - 1, 0)
            )

            for _, capture in ipairs(ok and captures or {}) do
                if vim.tbl_contains(opts.skip_ts, capture.capture) then
                    return o
                end
            end
        end

        return open(pair, neigh_pattern)
    end
end

M.active_statusline = function ()
    local MiniStatusline = require("mini.statusline")

    local opts = {
        mode = {
            trunc_width = 120,
        },
        git = {
            trunc_width = 40,
        },
        diff = {
            trunc_width = 75,
        },
        diagnostics = {
            trunc_width = 75,
            signs = {
                ERROR = "E",
                WARN = "W",
                INFO = "I",
                HINT = "H",
            },
        },
        lsp = {
            trunc_width = 75,
        },
        filename = {
            trunc_width = 140,
        },
        fileinfo = {
            trunc_width = 120,
        },
        search = {
            trunc_width = 75,
        },
        location = {
            trunc_width = 75,
        },
    }

    local mode, mode_hl = MiniStatusline.section_mode(opts.mode)
    local git = MiniStatusline.section_git(opts.git)
    local diff = MiniStatusline.section_diff(opts.diff)
    local diagnostics = MiniStatusline.section_diagnostics(opts.diagnostics)
    local lsp = MiniStatusline.section_lsp(opts.lsp)
    local filename = MiniStatusline.section_filename(opts.filename)
    local fileinfo = MiniStatusline.section_fileinfo(opts.fileinfo)
    local search = MiniStatusline.section_searchcount(opts.search)
    local location = MiniStatusline.section_location(opts.location)

    local groups = {
        {
            hl = mode_hl,
            strings = {
                mode,
            },
        },
        {
            hl = "MiniStatuslineDevinfo",
            strings = {
                git,
                diff,
                diagnostics,
                lsp,
            },
        },
        "%<",
        {
            hl = "MiniStatuslineFilename",
            strings = {
                filename,
            },
        },
        "%=",
        {
            hl = "MiniStatuslineFileinfo",
            strings = {
                fileinfo,
            },
        },
        {
            hl = mode_hl,
            strings = {
                search,
                location,
            },
        },
    }

    return MiniStatusline.combine_groups(groups)
end

M.inactive_statusline = function ()
    local MiniStatusline = require("mini.statusline")

    local groups = {
        {
            hl = "MiniStatuslineInactive",
            strings = {
                "%F",
            },
        },
        "%=",
    }

    return MiniStatusline.combine_groups(groups)
end

return M
