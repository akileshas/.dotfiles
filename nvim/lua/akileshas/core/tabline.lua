local cmd = vim.cmd
local o = vim.o
local fn = vim.fn

-- Set the tabline to use the custom tabline function
o.tabline = "%!v:lua.tabline()"

-- Custom tabline function
function _G.tabline()
	local tabline = ""
	local current_tab = fn.tabpagenr()

	-- Iterate over all tabs
	for i = 1, fn.tabpagenr("$") do
		local bufname = fn.bufname(fn.tabpagebuflist(i)[1])
		local filetype = fn.getbufvar(fn.tabpagebuflist(i)[1], "&filetype")

		-- Check if the buffer has no name
		local file_name = ""
		if bufname == "" then
			bufname = "Untitled"
			-- Assign a document icon if the buffer has no name
			file_name = "󱪞" -- Document icon for unnamed buffers
			file_name = " " .. file_name .. " " .. bufname .. " "
		else
			-- For Oil.nvim file explorer
			if filetype == "oil" then
				file_name = "  File Explorer "
			else
				file_name = fn.fnamemodify(bufname, ":t")
				-- Get file type icon using nvim-web-devicons
				local icon, _ = require("nvim-web-devicons").get_icon(file_name)

				-- Check if the buffer is modified
				local modified = fn.getbufvar(fn.tabpagebuflist(i)[1], "&modified") == 1 and " ● " or ""

				-- Add space before and after the icon and file name
				file_name = " " .. (icon or "") .. " " .. file_name .. modified .. " "
			end
		end

		-- Highlight the current tab with more prominent styling
		if i == current_tab then
			tabline = tabline .. "%" .. i .. "T" .. "%#TabLineSel#" .. file_name .. "%*"
		else
			tabline = tabline .. "%" .. i .. "T" .. "%#TabLine#" .. file_name .. "%*"
		end
	end

	-- Add final fill area at the end of the tabline
	tabline = tabline .. "%#TabLineFill#%T%="

	-- Set the background and foreground colors for the tabline
	cmd([[highlight TabLineFill guibg=#2f2f2f]])
	cmd([[highlight TabLineSel guibg=#1da1f2 guifg=#000000]])
	cmd([[highlight TabLine guibg=#1d1d1d guifg=#bfbfbf]])

	-- Return the final tabline
	return tabline
end
