local null_ls = require("null-ls")

null_ls.setup({
	on_attach = function(client, bufnr)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			prefer_local = "node_modules/.bin",
		}),
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.completion.spell,
	},
})
