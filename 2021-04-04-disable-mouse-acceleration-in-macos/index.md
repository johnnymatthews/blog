---
title: Disable mouse acceleration in MacOS
description: "MacOS is silly. One of the things that makes the operating silly is it's insistency on forcing mouse controlls to _accelerate_ before moving across the page. You know the deal: you move your mouse one inch to the left very slowly, and the cursor moves about half way across the screen. But if you shift your mouse to the left incredibly fast, then the cursor will scream across the screen and hit the monitor wall."
date: 2021-04-04
---

I like my cursor to move at a consistent rate, no matter how fast I move it. Luckily, disabling mouse-acceleration in MacOS is pretty simple:

1. Open the terminal.
1. Enter the following command

    ```shell
    defaults write .GlobalPreferences com.apple.mouse.scaling -1
    ```

1. That should be it!

The jury's still out on whether you need to do this every time you turn the computer on though.

