---
title: "Multipass ZSH completion"
description: "A tiny little completion script for Multipass that'll save you from typing out those pesky VM names every time."
date: 2025-05-22
---

If you're tired of typing `multipass list` just to remember what you called that Ubuntu instance, this script's for you. It adds proper tab completion to your shell so you can just type `multipass shell <TAB>` and see all your VMs pop up like magic.

## What it does

- Smart command completion: Type `multipass <TAB>` to see all available commands.
- Instance name completion: For commands like `shell`, `exec`, `start`, `stop`, etc., it'll show you all your actual VM instances.
- Works with most Multipass commands: Covers all the usual suspects you'd want to tab-complete.

## Prerequisities

- ZSH.
- Multipass installed and working.
- A basic grasp of how to edit text files.

## Installation

Dead simple:

1. Create a `completions` dir if you don't have one already:

   ```shell
   mkdir -p ~/.config/zsh/completions
   ```

1. Download the completion file into that dir:

    ```shell
    wget -O ~/.config/zsh/completions/_multipass https://raw.githubusercontent.com/johnnymatthews/multipass-zsh-autocomplete/refs/heads/yolo/_multipass
    ```

    If you've not got Wget installed (and don't wanna install it), use Curl like a pleb:

    ```shell
    curl -o ~/.config/zsh/completions/_multipass https://raw.githubusercontent.com/johnnymatthews/multipass-zsh-autocomplete/refs/heads/yolo/_multipass
    ```

1. Add these lines to your `~/.zshrc`:
   
   ```shell
   fpath=(~/.config/zsh/completions $fpath)
   autoload -Uz compinit && compinit
   ```

   I don't think it matters _where_ you put these lines, but it might. So, like, ask your local LLM or whatever.

1. Reload ZSH:

   ```shell
   source ~/.zshrc
   ```

1. Done.

## Usage

Now you can do lovely things like:

- `multipass shell <TAB>` to show all your running instances.
- `multipass stop <TAB>` show instances you can stop.
- `multipass <TAB>` to show all available commands.

## Troubleshooting

**Not working?** Make sure:

- The script is executable and in the right place
- You've reloaded your shell after editing `.zshrc`
- Multipass is actually installed and `multipass list` works from the command line

**Still not working?** Try running `compinit` manually to reinitialise completions.

**Still, still not working?** Drop an [issue](https://github.com/johnnymatthews/multipass-zsh-autocomplete/issues) in this repo.
