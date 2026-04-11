# Dotfiles Management Guide

This repository uses a custom wrapper script `manage.sh` for [Chezmoi](https://www.chezmoi.io/) to manage configurations.

## Essential Commands

The following commands should be run from the root of this repository:

### Preview Changes
To see what changes would be applied to your home directory without actually making them:
```bash
./manage.sh diff
```

### Apply Configurations
To synchronize the configurations from this repository to your system:
```bash
./manage.sh apply
```

## Tools

* **Config Management**: Chezmoi (managed via `manage.sh`)
* **Shell Environment**: Zsh
* **Text Editing**: Neovim
* **Terminal Multiplexing**: tmux
* **Fuzzy Search**: FZF
* **File Search**: Ripgrep (rg)
* **Directory Navigation**: Zoxide
* **Version Control**: Git

## Additional Commands
The `manage.sh` script passes all arguments directly to Chezmoi. For a full list of available commands and their usage, refer to the **[Chezmoi Command Overview](https://www.chezmoi.io/user-guide/command-overview/)**.
