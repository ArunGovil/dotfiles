local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
	"sumneko_lua",
	"tailwindcss",
	"vuels",
	"prismals",
})

lsp.set_preferences({
	cmp_capabilities = true,
	configure_diagnostics = true,
	manage_nvim_cmp = true,
	sign_icons = {
		error = "E",
		warn = "W",
		info = "I",
		hint = "H",
	},
})

lsp.configure("tsserver", {
	on_attach = function(client, bufnr) end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "typescript.ts" },
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
})

lsp.configure("vuels", {})

lsp.setup()

vim.opt.signcolumn = "yes"
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
