-- plugin dependencies
local dependencies = {
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",
	"moyiz/blink-emoji.nvim",
	"giuxtaposition/blink-cmp-copilot",
}

-- plugin options
local options = {
	enabled = function()
		local filetype = vim.bo[0].filetype
		if filetype == "oil" or filetype == "snacks_picker_input" then
			return false
		end
		return true
	end,
	snippets = {
		preset = "luasnip",
	},
	completion = {
		list = {
			max_items = 300,
			selection = {
				preselect = true,
				auto_insert = true,
			},
			cycle = {
				from_bottom = true,
				from_top = true,
			},
		},
		menu = {
			border = "rounded",
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			treesitter_highlighting = true,
			window = {
				border = "rounded",
			},
		},
		ghost_text = {
			enabled = false,
		},
	},
	signature = {
		enabled = true,
		trigger = {
			show_on_insert = true,
		},
		window = {
			border = "rounded",
			treesitter_highlighting = true,
			show_documentation = true,
		},
	},
	fuzzy = {
		implementation = "prefer_rust",
	},
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
			"emoji",
			"copilot",
		},
		providers = {
			lsp = {
				name = "lsp",
				enabled = true,
				module = "blink.cmp.sources.lsp",
				score_offset = 90,
			},
			path = {
				name = "path",
				enabled = true,
				module = "blink.cmp.sources.path",
				score_offset = 10,
				fallbacks = { "snippets", "buffer" },
				opts = {
					trailing_slash = true,
					label_trailing_slash = true,
					get_cwd = function(context)
						return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
					end,
					show_hidden_files_by_default = true,
				},
			},
			snippets = {
				name = "snippets",
				enabled = true,
				module = "blink.cmp.sources.snippets",
				score_offset = 85,
				max_items = 15,
			},
			buffer = {
				name = "buffer",
				enabled = true,
				module = "blink.cmp.sources.buffer",
				score_offset = 5,
				max_items = 5,
			},
			emoji = {
				name = "emoji",
				enabled = true,
				module = "blink-emoji",
				score_offset = 95,
				opts = {
					insert = true,
				},
			},
			copilot = {
				name = "copilot",
				enabled = true,
				module = "blink-cmp-copilot",
				score_offset = 15,
				async = true,
				transform_items = function(_, items)
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1
					CompletionItemKind[kind_idx] = "Copilot"
					for _, item in ipairs(items) do
						item.kind = kind_idx
					end
					return items
				end,
			},
		},
	},
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},
	cmdline = {
		enabled = true,
		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = true,
				},
			},
			menu = {
				auto_show = true,
			},
			ghost_text = {
				enabled = false,
			},
		},
		keymap = {
			preset = "cmdline",
			["<C-space>"] = {
				"show_documentation",
				"hide_documentation",
			},
			["<C-s>"] = {
				"show",
			},
			["<C-e>"] = {
				"cancel",
			},
			["<C-y>"] = {},
			["<C-k>"] = {
				"select_and_accept",
			},
			["<C-p>"] = {
				"select_prev",
				"snippet_backward",
				"fallback",
			},
			["<C-n>"] = {
				"select_next",
				"snippet_forward",
				"fallback",
			},
			["<Up>"] = {},
			["<Down>"] = {},
			["<Right>"] = {},
			["<Left>"] = {},
			['<C-b>'] = {
				"scroll_documentation_up",
				"fallback",
			},
			['<C-f>'] = {
				"scroll_documentation_down",
				"fallback",
			},
			["<Tab>"] = {},
			["<S-Tab>"] = {},
			["<C-d>"] = {
				"show_signature",
				"hide_signature",
				"fallback",
			},
		},
	},
	term = {
		enabled = false,
		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = true,
				},
			},
			menu = {
				auto_show = true,
			},
			ghost_text = {
				enabled = false,
			},
		},
	},
	keymap = {
		preset = "default",
		["<C-space>"] = {
			"show_documentation",
			"hide_documentation",
		},
		["<C-s>"] = {
			"show",
		},
		["<C-e>"] = {
			"cancel",
		},
		["<C-y>"] = {},
		["<C-k>"] = {
			"select_and_accept",
		},
		["<C-p>"] = {
			"select_prev",
			"snippet_backward",
			"fallback",
		},
		["<C-n>"] = {
			"select_next",
			"snippet_forward",
			"fallback",
		},
		["<Up>"] = {},
		["<Down>"] = {},
		["<Right>"] = {},
		["<Left>"] = {},
		['<C-b>'] = {
			"scroll_documentation_up",
			"fallback",
		},
		['<C-f>'] = {
			"scroll_documentation_down",
			"fallback",
		},
		["<Tab>"] = {},
		["<S-Tab>"] = {},
		["<C-d>"] = {
			"show_signature",
			"hide_signature",
			"fallback",
		},
	},
}

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
	"saghen/blink.cmp",
	build = 'cargo build --release',
	lazy = true,
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
	dependencies = dependencies,
	opts = options,
	keys = keymaps,
}
