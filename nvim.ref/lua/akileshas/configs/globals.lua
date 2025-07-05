local fn = vim.fn
local g = vim.g

-- animate
g.snacks_animate = false

-- font
g.have_nerd_font = true

-- leader
g.mapleader = " "
g.maplocalleader = "\\"

-- loader
g.loaded_perl_provider = 0
-- g.loaded_python3_provider = 0
-- g.loaded_node_provider = 0
g.loaded_ruby_provider = 0
g.python3_host_prog = fn.exepath("python")

-- markdown
g.markdown_recommended_style = 0

-- messages
g.deprecation_warnings = false

-- netrw
g.netrw_liststyle = 3

return {}
