<h3 align="center">
Neovim dotfiles ⚡</h3>

---

### What's this?

My personal Neovim config — minimal, fast, and opinionated. Uses lazy.nvim for plugin management with LSP, Telescope, Treesitter, and formatting out of the box.

### How to install?

```sh
# Back up existing config if any
mv ~/.config/nvim ~/.config/nvim.bak

# Clone and open
git clone git@github.com:ArunGovil/dotfiles.git ~/.config/nvim
nvim
```

Lazy.nvim will auto-install all plugins on first launch. Mason will set up language servers and formatters.

> **Note**
> Requires Neovim >= 0.10 and git. Some formatters (like prettierd) need to be installed separately.
