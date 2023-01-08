local null_ls = require('null-ls')

null_ls.setup({
  on_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup('null_format', {clear = true})
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      desc = 'Fix and format',
      callback = function()
        vim.cmd('EslintFixAll')
        vim.lsp.buf.format({id = client.id})
      end
    })
  end,
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      prefer_local = 'node_modules/.bin',
    })
  }
})
