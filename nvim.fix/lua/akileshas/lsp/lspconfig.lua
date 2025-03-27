-- plugin dependencies
local dependencies = {}

-- plugin options
local options = {}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local lspconfig = require("lspconfig")

	if opts == nil then
		opts = {}
	end

	-- configure lspconfig
	lspconfig.setup(opts)
end

-- plugin keymaps
local keymaps = {}

return {
}
