---
title: Disable GPG password pop-up
description: "When you try to decrypt something with a GPG that has a password, the OS you're using will prompt you to enter that password. Some operating systems, like PopOS, have a pop-up style prompt for you to enter the password. I don't like this, and much prefer the terminal prompt."
date: 2021-09-22
---

Entering your password on things like this is called _pinentry_, for some reason. I'm guessing it's because back in the day, nerds called passwords _pins_. Anyway, we need to change the _pinentry_ setting for the terminal.

1. List your pinentry options: 

    ```shell
    sudo update-alternatives --config pinentry

    There are 3 choices for the alternative pinentry (providing /usr/bin/pinentry). 

        Selection   Path                        Priority    Status
    -----------------------------------------------------------------
    *   0           /usr/bin/pinentry-gnome3    90          auto mode
        1           /usr/bin/pinentry-curses    50          manual mode
        2           /usr/bin/pinentry-gnome3    90          manual mode

    Press <enter> to keep the current choice[*], or type selection number: 
    ```

1. Select a choice from the options by entering a number. If you don't see anything that looks like a terminal-based entry method, you can install one:

    ```shell
    sudo apt install pinentry-tty
    ```

1. Run `sudo update-alternatives --config pinentry` again, and select `pinentry-tty` from the list.
1. That's it!

