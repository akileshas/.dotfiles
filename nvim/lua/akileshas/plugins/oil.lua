-- toggle file/directory details
local details_shown = true
local toggle_details = function()
	if details_shown then
		require("oil").set_columns({
			{
				"icon",
			},
			{
				"permissions",
				highlight = "Comment",
			},
			{
				"size",
				highlight = "Comment",
			},
			{
				"mtime",
				highlight = "Comment",
				format = "%d/%m/%Y %I:%M:%S %p",
			},
		})
		details_shown = false
	else
		require("oil").set_columns({
			{
				"icon",
			},
		})
		details_shown = true
	end
end

-- plugin dependencies
local dependencies = {
	"nvim-tree/nvim-web-devicons",
}

-- plugin options
local options = {
	default_file_explorer = true,
	columns = {
		{
			"icon",
		},
	},
	delete_to_trash = true,
	keymaps = {
		["<C-h>"] = {},
		["<C-l>"] = {},
		["~"] = {
			"<cmd>edit $HOME<CR>",
			mode = "n",
		},
		["`"] = {
			"actions.tcd",
			mode = "n",
		},
		["gr"] = {
			"actions.refresh",
			mode = "n",
		},
		["gd"] = {
			toggle_details,
			mode = "n",
			nowait = true,
			desc = "Toggle the file/directory details ( premissions, size, last_modified_date )",
		},
	},
	view_options = {
		show_hidden = true,
		highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan, bufnr)
			if is_hidden then
				if entry.type == "directory" then
					return "OilDir"
				else
					return "OilFile"
				end
			end
			return nil
		end,
	}
}

-- plugin keymaps
local keymaps = {
	{
		"<leader>ef",
		mode = "n",
		"<cmd>Oil<CR>",
		noremap = true,
		silent = true,
		desc = "Open parent directory",
	}
}

-- plugin configurations
return {
	"stevearc/oil.nvim",
	lazy = true,
	dependencies = dependencies,
	opts = options,
	keys = keymaps,
}
