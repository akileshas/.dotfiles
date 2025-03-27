-- list of parsers to be installed
local ensure_installed = {
	"angular",
	"arduino",
	"asm",
	"astro",
	"bash",
	"c",
	"c_sharp",
	"clojure",
	"cmake",
	"comment",
	"commonlisp",
	"cpp",
	"css",
	"csv",
	"cuda",
	"diff",
	"disassembly",
	"dockerfile",
	"elixir",
	"erlang",
	"fish",
	"fsharp",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"goctl",
	"gomod",
	"gosum",
	"gotmpl",
	"gowork",
	"graphql",
	"haskell",
	"haskell_persistent",
	"html",
	"http",
	"java",
	"javadoc",
	"javascript",
	"jinja",
	"jinja_inline",
	"jq",
	"jsdoc",
	"json",
	"json5",
	"jsonc",
	"jsonnet",
	"julia",
	"just",
	"kotlin",
	"latex",
	"ledger",
	"linkerscript",
	"llvm",
	"lua",
	"luadoc",
	"luau",
	"make",
	"markdown",
	"markdown_inline",
	"matlab",
	"meson",
	"nginx",
	"ninja",
	"nix",
	"norg",
	"objc",
	"objdump",
	"ocaml",
	"ocaml_interface",
	"ocamllex",
	"odin",
	"pascal",
	"perl",
	"php",
	"php_only",
	"phpdoc",
	"powershell",
	"prisma",
	"puppet",
	"purescript",
	"pymanifest",
	"python",
	"query",
	"r",
	"regex",
	"requirements",
	"rescript",
	"ruby",
	"runescript",
	"rust",
	"scala",
	"scss",
	"solidity",
	"sql",
	"ssh_config",
	"strace",
	"superhtml",
	"svelte",
	"swift",
	"terraform",
	"tmux",
	"toml",
	"tsv",
	"tsx",
	"typescript",
	"typespec",
	"typoscript",
	"vim",
	"vimdoc",
	"vue",
	"xml",
	"yaml",
	"zig",
	"ziggy",
	"ziggy_schema",
}

-- list of parsers to be ignored
local ignore_install = {}

-- list of parsers to disable highlight
local highlight_disable = {}

-- plugin dependencies
local dependencies = {
	"nvim-treesitter/nvim-treesitter-refactor",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"RRethy/nvim-treesitter-textsubjects",
}

-- textsubjects options
local textsubjects_options = {
	enable = true,
	prev_selection = ",",
	keymaps = {
		["."] = {
			"textsubjects-smart",
			desc = "select the current text subject",
		},
		["a;"] = {
			"textsubjects-container-outer",
			desc = "select outer container (class, function, etc.)",
		},
		["i;"] = {
			"textsubjects-container-inner",
			desc = "select inside containers (classes, functions, etc.)",
		},
	},
}

-- textobject options
local textobjects_options = {
	select = {
		enable = true,
		lookahead = true,
		keymaps = {},
		selection_modes = {},
		include_surrounding_whitespace = true,
	},
	swap = {
		enable = true,
		swap_next = {},
		swap_previous = {},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {},
		goto_next_end = {},
		goto_previous_start = {},
		goto_previous_end = {},
		goto_next = {},
		goto_previous = {},
	},
}

-- refactor options
local refactor_options = {
	highlight_definitions = {
		enable = true,
		clear_on_cursor_move = true,
	},
	highlight_current_scope = {
		enable = true,
	},
	smart_rename = {
		enable = true,
		keymaps = {
			smart_rename = "<leader>rr",
		},
	},
	navigation = {
		enable = true,
		keymaps = {
			goto_definition = "<leader>rd",
			list_definitions = "<leader>rl",
			list_definitions_toc = "<leader>rh",
			goto_next_usage = "<leader>rj",
			goto_previous_usage = "<leader>rk",
		},
	},
}

-- treesitter options
local treesitter_options = {
	ensure_installed = ensure_installed,
	sync_install = false,
	auto_install = true,
	ignore_install = ignore_install,
	highlight = {
		enable = true,
		disable = highlight_disable,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	indent = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
	textobjects = textobjects_options,
	refactor = refactor_options,
}

-- plugin options
local options = {}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local treesitter = require("nvim-treesitter.configs")
	local treesitter_textsubjects = require('nvim-treesitter-textsubjects')
	local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

	-- configure treesitter
	treesitter.setup(treesitter_options)

	-- configure textsubjects
	treesitter_textsubjects.configure(textsubjects_options)
end

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = true,
	event = {
		'BufReadPost',
		'BufNewFile'
	},
	dependencies = dependencies,
	opts = options,
	config = config,
	keys = keymaps,
}
