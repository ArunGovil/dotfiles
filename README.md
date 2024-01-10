<h3 align="center">
The repository contains dotfiles for my Neovim setup! ⚡</h3>

---

### What are these dotfiles for?

The dotfiles in this repository holds the configuration for my Neovim text editor setup, which I currently use for most of my developer workflow.

### What features does the environment have?

The setup is being actively updated as I'm diving deeper into Neovim ecosystem. Some of the present features include:

- Status Line
- Auto close tags
- Telescope fuzz finder
- Git integration
- Lazy Nvim package manager

### How to install the config?

To make use of the dotfiles, clone the repo to your nvim config path.

```sh
cd .config/nvim

git clone git@github.com:ArunGovil/dotfiles.git
```

After cloning, open nvim and install the packages using Lazy.

```sh
nvim .

:Lazy
```

Once the installation is complete, all configuration will be applied to your neovim.

<br>

> **Note**
> Some of the configurations will require additional installations, like [prettierd](https://github.com/fsouza/prettierd).

### How to configure Tmux?

Tmux can be configured by editing tmux.conf file which is present in the root directory. If the file is not present you can simply create one and save with your configurations.

```sh
nvim ~/.tmux.conf
```

You can find my Tmux config file [here](https://gist.github.com/ArunGovil/7b19897f6d872113c0ce71646884dba0).
