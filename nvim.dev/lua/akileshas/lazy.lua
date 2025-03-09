local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- for convenience
local fn = vim.fn
local loop = vim.loop
local opt = vim.opt

if not loop.fs_stat(lazypath) then
	fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "akileshas.plugins" },
	{ import = "akileshas.lsp" },
}, {
	checker = {
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})

return {}
