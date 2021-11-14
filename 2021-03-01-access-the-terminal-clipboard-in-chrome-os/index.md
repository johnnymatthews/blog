---
title: Access the terminal clipboard in ChromeOS
date: 2021-03-01
description: By default, you cannot copy something from the terminal into ChromeOS. If you want to access the terminal clipboard, you need to install the wl-clipboard package. 
---

# Access the terminal clipboard in ChromeOS

The `wl-clipboard` package is available on [GitHub](https://github.com/bugaevc/wl-clipboard).

1. Open the terminal.
1. Download the [`wl-clipboard` package](https://github.com/bugaevc/wl-clipboard):

    ```shell
    wget http://ftp.us.debian.org/debian/pool/main/w/wl-clipboard/wl-clipboard_2.0.0-1_amd64.deb 
    ```

1. Install the package:

    ```shell
    sudo dpkg -i wl-clipboard_2.0.0-1_amd64.deb
    ```

1. You can now copy things to the ChromeOS clipboard by running `wl-copy`:

    ```shell
    cat ~/.ssh/id_rsa.pub | wl-copy
    ```

A copy of the `wl-clipboard_2.0.0-1_amd64.deb` package is available on IPFS:

    ```shell
    wget https://gateway.pinata.cloud/ipfs/Qma7HNYQ2pxH3y5S9mxL6xfybLMg6vEHhqV3a8qidLt4Sj
    ```
