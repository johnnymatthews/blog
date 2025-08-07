---
title: "Installing things locally is bad, kinda."
description: "I travel a lot, which oftens means I have shakey or non-existent wifi. So I generally prefer to install things locally. However, over the past three-or-so years, there has been a huge uptick in attacks targetting developers by infiltrating their local NPM, Pip, or insert-package-manager-here directories. I'm not gonna get into how these attacks work in this post, but I am gonna lay out my method for protecting myself on MacOS by using Multipass."
date: 2025-08-07
---

Multipass is a straight-forward virtual machine (VM) management application from Canonical (the folks who make and maintain Ubuntu). Basically, Multipass lets you run Unix-based oses straight from the terminal on Apple silicon. Applications like QEMU, VirtualBox, and VMWare let you do this already, but I find Multipass to be the simpliest approach if you don't care about GUIs or GPU-accessiblity or anything like that. I've got another guide in the mix for opening a GUI application in a Multipass VM; maybe I'll post a link to it here once it's out (if I remember).

**Sidenote**: I wrote another guide called [Create a Pen Testing Ubuntu VM](../2025-05-15-create-a-pen-testing-ubuntu-vm) that uses Multipass, but it kinda skims over everything in favour of installing Kali-tools. This guide is a more general-purpose guide that more people might find useful (hopefully).

We're gonna run through three things here:

1. Installing Multipass.
1. Adding the tab-completion for Multipass (which I wrote, so that's cool).
1. Spinning up a virtual machine.


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

### Add tab-completion for ZSH

This step is optional but useful if you, like me, end up with tens of VMs sat in Multipass. All we're doing is setting up ZSH so that when you type `multipass shell/start/stop/delete/whatever` and hit `TAB`, the terminal will autocomplete your available options (in this case VM names).

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

Now to the fun stuff.

1. Create a VM with custom specs:

   ```shell
   multipass launch --name my-dev-box --cpus 2 --memory 4G --disk 30G
   ```

   This gives you 2 CPUs, 4GB of RAM, and 30GB of disk space. For reference, I'm running an M4 MacBook Air with 24GB of RAM, and I give each of my VMs 8GB of RAM and 4 CPUs with 30GB of disk space. I generaly only run one VM at a time though.

1. Check that your VM is running:

   ```shell
   multipass list
   ```

   ```output
   Name                    State             IPv4             Image
   my-dev-box              Running           192.168.64.2     Ubuntu 24.04 LTS
   ```

1. Shell into your new VM:

   ```shell
   multipass shell my-dev-box
   ```

   You should now be inside your Ubuntu VM. The prompt will change to something like `ubuntu@my-dev-box:~$`.

1. Install whatever you need without worrying about mucking up your host machine:

   ```shell
   sudo apt update && sudo apt upgrade -y
   sudo apt install nodejs npm python3-pip git -y
   npm install --global some-sketchy-package
   ```

   If you break something, just delete the VM and start again.

1. When you're done, exit the VM:

   ```shell
   exit
   ```

1. Stop the VM to save resources:

   ```shell
   multipass stop my-dev-box
   ```

   Tack on the `--all` option if you can't be arse typing out your VM name:

   ```shell
   multipass stop --all
   ``` 

1. Delete the VM entirely once you're done with it:

   ```shell
   multipass delete my-dev-box --purge
   ```

That's it! You've now got a sandboxed Ubuntu environment to use for testing sketchy packages or just keeping your local environment clean.
