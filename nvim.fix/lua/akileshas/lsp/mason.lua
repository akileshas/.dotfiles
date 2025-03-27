-- list of lsp servers to be installed
local ensure_installed = {
	"angularls",
}

-- plugin dependencies
local dependencies = {

}

-- plugin options
local options = {
	ui = {
		icons = {
			check_outdated_packages_on_open = true,
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

-- plugin config function
local config = function(_, opts)
	-- for convenience
	local mason = require("mason")

	if opts == nil then
		opts = {}
	end

	-- configure mason
	mason.setup(opts)
end

-- plugin keymaps
local keymaps = {}

-- plugin configurations
return {
}
