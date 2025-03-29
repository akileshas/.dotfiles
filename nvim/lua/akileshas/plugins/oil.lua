-- for convenience
local cmd = vim.cmd

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
	{
		"nvim-tree/nvim-web-devicons",
	},
}

-- plugin init function
local init = function() end

-- plugin opts
local opts = {
	default_file_explorer = true,
	columns = {
		{
			"icon",
		},
	},
	delete_to_trash = true,
	keymaps = {
		["<C-s>"] = {},
		["<C-x>"] = {
			"actions.select",
			opts = {
				vertical = true,
			},
		},
		["<C-h>"] = {},
		["<C-y>"] = {
			"actions.select",
			opts = {
				horizontal = true,
			},
		},
		["<C-p>"] = {},
		["<C-d>"] = {
			"actions.preview",
		},
		["<C-l>"] = {},
		["<C-u>"] = {
			"actions.refresh",
			mode = { "n" },
		},
		["`"] = {
			"actions.tcd",
			mode = { "n" },
		},
		["~"] = {
			"<cmd>tabedit $HOME<CR>",
			mode = { "n" },
		},
		["gd"] = {
			toggle_details,
			mode = { "n" },
			nowait = true,
			desc = "toggle the file/directory details ( premissions, size, last_modified_date )",
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
	},
}

-- plugin keys
local keys = {
	{
		"<leader>ef",
		mode = { "n" },
		function()
			cmd("Oil")
		end,
		noremap = true,
		silent = true,
		desc = "open parent directory",
	},
}

-- plugin configurations
return {
	"stevearc/oil.nvim",
	version = "*",
	enabled = true,
	lazy = true,
	event = {},
	cmd = {},
	ft = {},
	build = {},
	dependencies = dependencies,
	init = init,
	opts = opts,
	keys = keys,
}
