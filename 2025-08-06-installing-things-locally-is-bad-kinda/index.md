---
title: "Installing things locally is bad, kinda."
description: "I travel a lot, which oftens means I have shakey or non-existent wifi. So I generally prefer to install things locally. However, over the past three-or-so years, there has been a huge uptick in attacks targetting developers by infiltrating their local NPM, Pip, or insert-package-manager-here directories. I'm not gonna get into how these attacks work in this post, but I am gonna lay out my method for protecting myself on MacOS by using Multipass."
date: 2025-08-06
---

Multipass is a straight-forward virtual machine (VM) management application from Canonical (the folks who make and maintain Ubuntu). Basically, Multipass lets you run Unix-based oses straight from the terminal on Apple silicon. Applications like QEMU, VirtualBox, and VMWare let you do this already, but I find Multipass to be the simpliest approach if you don't care about GUIs or GPU-accessiblity or anything like that. I've got another guide in the mix for opening a GUI application in a Multipass VM; maybe I'll post a link to it here once it's out (if I remember).

We're gonna run through three things here:

1. Installing Multipass.
1. Adding the tab-completion for Multipass (which I wrote, so that's cool).
1. Spinning up a Ubuntu VM.
1. Spinning up a non-Debian-based VM (in this case, Alpine Linux).

> I wrote another guide called [](../2025-05-15-create-a-pen-testing-ubuntu-vm) that uses Multipass, but it kinda skims over everything in favour of installing Kali-tools. This guide is a more general-purpose guide that more people might find useful (hopefully).

