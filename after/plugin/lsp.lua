local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
        'tsserver',
        'eslint',
        'sumneko_lua',
        'tailwindcss',
        'vuels',
        'prismals',
})

lsp.set_preferences({
        sign_icons = {
                error = 'E',
                warn = 'W',
                info = 'I'
        }
})

lsp.configure('tsserver', {
  on_attach = function(client, bufnr)
  end,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "typescript.ts" },
  settings = {
    completions = {
      completeFunctionCalls = true
    }
  }
})

lsp.setup()
