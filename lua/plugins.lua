local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " " 

require("lazy").setup({
{ "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },
{ "nvim-lualine/lualine.nvim", lazy = false, priority = 1000 },
{'akinsho/toggleterm.nvim', version = "*", config = true},
{'lewis6991/gitsigns.nvim', version = "*", config = true},
{'nvim-lua/plenary.nvim'},
{'windwp/nvim-autopairs', version = "*", config = true},
{'windwp/nvim-ts-autotag', version = "*", config = true},
{'BurntSushi/ripgrep'},
{'nvim-treesitter/nvim-treesitter', version = "*", config = true},
{'nvim-telescope/telescope.nvim', version = "*", config = true},
{"neovim/nvim-lspconfig"},
{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {},
  config = function()
    require("nvim-tree").setup {
            disable_netrw = true,
            hijack_netrw = true,
            open_on_tab = true,
    }
    end,
}
})

vim.cmd [[colorscheme catppuccin]]
