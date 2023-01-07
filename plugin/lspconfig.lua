local status, nvim_lsp = pcall(require, 'lspconfig')
if (not status) then return end

local protocol = require('vim.lsp.protocol')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_command [[augroup Format]]
                vim.api.nvim_command [[autocmd! * <buffer>]]
                vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
                vim.api.nvim_command [[augroup END]]
        end
end

nvim_lsp.tsserver.setup {
        on_attach = on_attach,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "typescript.ts" },
        cmd = { "typescript-language-server", "--stdio" },
        capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
        on_attach = on_attach,
        settings = {
                Lua = {
                        diagnostics = {
                                globals = { 'vim' }
                        },
                        workspace = {
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false
                        },
                },
        },
}

nvim_lsp.tailwindcss.setup {
        on_attach = on_attach,
        capabilities = capabilities
}

nvim_lsp.vuels.setup {
        on_attach = on_attach,
        capabilities = capabilities
}

nvim_lsp.prismals.setup {
        on_attach = on_attach,
        capabilities = capabilities
}

nvim_lsp.pyright.setup {}
