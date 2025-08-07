---
title: "Installing things locally is bad, kinda."
description: "I travel a lot, which oftens means I have shakey or non-existent wifi. So I generally prefer to install things locally. However, over the past three-or-so years, there has been a huge uptick in attacks targetting developers by infiltrating their local NPM, Pip, or insert-package-manager-here directories. I'm not gonna get into how these attacks work in this post, but I am gonna lay out my method for protecting myself on MacOS by using Multipass."
date: 2025-08-06
---

Multipass is a straight-forward virtual machine (VM) management application from Canonical (the folks who make and maintain Ubuntu). Basically, Multipass lets you run Unix-based oses straight from the terminal on Apple silicon. Applications like QEMU, VirtualBox, and VMWare let you do this already, but I find Multipass to be the simpliest approach if you don't care about GUIs or GPU-accessiblity or anything like that. I've got another guide in the mix for opening a GUI application in a Multipass VM; maybe I'll post a link to it here once it's out (if I remember).

We're gonna run through three things here:

1. Installing Multipass.
1. Adding the tab-completion for Multipass (which I wrote, so that's cool).
1. Spinning up a virtual machine.

> I wrote another guide called [](../2025-05-15-create-a-pen-testing-ubuntu-vm) that uses Multipass, but it kinda skims over everything in favour of installing Kali-tools. This guide is a more general-purpose guide that more people might find useful (hopefully).

## Install Multipass

This is probably the easiest step since all you need is [Homebrew](https://brew.sh/).

1. Check you've got Homebrew installed:

  ```shell
  brew --version
  ```

  ```output
  Homebrew 4.6.0
  ```

1. Install the Multipass cask:

  ```shell
  brew install --cask multipass
  ```

1. Check that Multipass got installed correctly:

  ```shell
  multipass --version
  ```

  ```output
  multipass   1.16.0+mac
  multipassd  1.16.0+mac
  ```

1. Done!

### Add tab-completion

This step is optional but useful if you, like me, end up with tens of VMs sat in Multipass. All we're doing is setting up ZSH so that when you type `multipass shell/start/stop/delete/whatever` and hit `TAB`, the terminal will autocomplete your available options (in this case VM names).

> [!NOTE]
> This tab-completion script/engine/thingy was written for ZSH. If you're using something like Bash or Fish then you'll have to find something else.

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

   I don't think it matters _where_ you put these lines, but it might. Ask your local Gen AI bot.

1. Reload ZSH:

   ```shell
   source ~/.zshrc
   ```

1. Done.

## Make a Ubuntu box


