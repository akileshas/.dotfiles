-- for convenience
local fn = vim.fn
local g = vim.g

-- leader key settings
g.mapleader = " "
g.maplocalleader = "\\"

-- netrw settings
g.netrw_liststyle = 3

-- markdown settings
g.markdown_recommended_style = 0

-- animate settings
g.snacks_animate = false

-- font settings
g.have_nerd_font = true

-- neovim loader settings
g.python3_host_prog = fn.exepath("python")
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
-- g.loaded_node_provider = 0
-- g.loaded_python3_provider = 0

-- message settings
g.deprecation_warnings = false

return {}
