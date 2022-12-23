---
title: "Reset WSL clock"
description: "I'm not sure why this keeps happening, but every now and again the clock within WSL (and WSL2) get massively out of sync. Here's how to reset it."
date: 2022-12-23
---

1. Run `hwclock -s` as sudo:

    ```shell
    sudo hwclock -s
    ```

1. That's it.
