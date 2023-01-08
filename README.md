<h3 align="center">
The repository contains dotfiles for my Neovim setup. ⚡</h3>

---

### What are these dotfiles for?

The dotfiles in this repository holds the configuration for my Neovim text editor setup, which I currently use for most of my developer workflow.

### What features does the environment have?

The setup is being actively updated as I'm diving deeper into Neovim ecosystem. Some of the present features include:

- Syntax Highlighting
- Status Line
- Live suggestions
- Multiple Language support
- Prettier Code formatting
- Auto close tags
- Telescope fuzz finder
- Git integration
- Packer package management

### How to install the config?

To make use of the dotfiles, clone the repo to your nvim config path.
```sh
cd .config/nvim

git clone git@github.com:ArunGovil/dotfiles.git
```
After cloning, open nvim and install the packages using Packer.
```sh
nvim .

:PackerInstall
```
Once the installation is complete, all configuration will be applied to your neovim.

<br>

> **Note**
> Some of the configurations will require additional installations, like [prettierd](https://github.com/fsouza/prettierd).
