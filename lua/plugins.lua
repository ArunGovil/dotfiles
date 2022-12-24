local status, packer = pcall(require, 'packer')
if (not status) then
        print("Packer is not installed")
        return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
        use 'wbthomason/packer.nvim'
        use {
                'svrana/neosolarized.nvim',
                requires = { 'tjdevries/colorbuddy.nvim' }
        }
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'MunifTanjim/prettier.nvim'
        use 'kyazdani42/nvim-web-devicons'
        use 'L3MON4D3/LuaSnip'
        use 'hoob3rt/lualine.nvim'
        use 'onsails/lspkind-nvim'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/nvim-cmp'
        use 'neovim/nvim-lspconfig'
        use 'nvim-lua/plenary.nvim'
        use 'nvim-telescope/telescope.nvim'
        use 'nvim-telescope/telescope-file-browser.nvim'
end)
