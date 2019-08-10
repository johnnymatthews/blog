---
title: How to Update your CMUS Library
date: 2018-05-09
---

CMUS is a fantastically simple music player for Unix systems. It just runs in the terminal and requires hardly any memory to run! This low memory requirement is actually why I go onto using it in the first place. Between Chrome, Slack, and VSCode, I don't have much memory left to go around in my 8GB MacBook.

I often find myself updating my music library, which can cause CMUS to go out sync. So I began looking for a solution to help me update the CMUS cache on the fly! I found a post on [Github by c0llision](https://github.com/cmus/cmus/issues/233#issuecomment-396195503) that guided me to the script below!

All it does is bind a few commands to the `u` key in CMUS. So every time you need to update your CMUS library, just press the `u` key on your keyboard!

1. Create the following file:

    ```bash
    #!/bin/bash
    cmus-remote -C clear
    cmus-remote -C "add ~/Music"
    cmus-remote -C "update-cache -f"
    ```

2. Name it `update-library.sh` and save it somewhere. I've saved mine at `~/Applications/cmus-osx` directory.

3. Change the permissions to make the script executable:

    ```bash
    chmod +x ~/Applications/cmus-osx/update-library.sh
    ```

4. Open `CMUS`:

    ```bash
    cmus
    ```

5. Enter the following within `CMUS` to bind the update script to the `u` key:

    ```bash
    :bind -f common u shell ~/Applications/cmus-osx/update-library.sh
    ```

6. There you go! You can new press the `u` key to update your entire library when within `CMUS`.
