vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.shell = "bash"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.cursorline = false
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 10
vim.opt.laststatus = 2
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.background = "dark"
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.fillchars = { eob = " ", diff = "╱" }
vim.api.nvim_create_autocmd({ "QuitPre" }, {
	callback = function()
		vim.cmd("NvimTreeClose")
	end,
})
