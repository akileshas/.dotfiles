-- for convenience
local fn = vim.fn
local loop = vim.loop
local uv = vim.uv
local v = vim.v
local api = vim.api
local opt = vim.opt

-- bootstrap lazy.nvim
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (uv or loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath
	})
	if v.shell_error ~= 0 then
		api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		fn.getchar()
		os.exit(1)
	end
end
opt.rtp:prepend(lazypath)

-- lazy options
local options = {
	spec = {
		{ import = "akileshas.plugins" },
		{ import = "akileshas.lsp" },
	},
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
}

require("lazy").setup(options)

return {}
