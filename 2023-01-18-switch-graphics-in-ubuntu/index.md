---
title: "Switch graphics in Ubuntu"
description: "Ubuntu doesn't have a built-in GUI for switching graphics settigs like PopOS. But no matter, there's a terminal command that'll work just fine! Unfortunately, this only works for systems running an Intel CPU."
date: 2023-01-18
---

1. Open terminal.
1. Use `prime-select` as a super-user to select the graphics type you want. For integrated graphics run:

    ```shell
    sudo prime-select intel 
    ```

1. To use the dedicated graphics, use `nvidia`:

    ```shell
    sudo prime-select nvidia
    ```

1. You can also use `query` to see which graphics setting is selected:

    ```shell
    prime-select query
    ```

1. That's it.
