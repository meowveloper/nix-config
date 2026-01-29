# AstroNvim Setup Instructions

This document provides instructions on how to set up and configure your AstroNvim environment.

## 1. Installation

These instructions assume you have cloned this repository to `~/.config/nvim`.

### Make a backup of your current nvim and shared folder

It is always a good idea to back up your existing Neovim configuration before making changes.

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### Clone the repository

If you haven't already, clone your user configuration repository to the correct location.

```shell
git clone https://github.com/<your_user>/<your_repository> ~/.config/nvim
```

### Start Neovim

The first time you start Neovim, AstroNvim will install all the necessary plugins.

```shell
nvim
```

## 2. Configuration

Your personal configuration is located in the `lua/user` directory. The main entry point for your custom configuration is `lua/user/init.lua`.

You can add your own plugins in `lua/user/plugins/` and custom configuration in other files within the `lua/user/` directory.

For more information, please refer to the [AstroNvim documentation](https://astronvim.com/).
