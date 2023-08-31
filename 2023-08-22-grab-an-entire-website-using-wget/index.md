---
title: "Grab an entire website using wget"
description: "Learn how to grab an entire website using wget. You can then use this site as a static mirror."
date: 2023-08-22
---

Sometimes you need a static mirror of a dynamic site, just in case things go pear-shaped.

1. Make sure you have `wget `installed:

    ```shell
    wget --version
    ```

1. Run `wget` with, like, a gazzilion arguments:

    ```shell
    wget -mkxKE -e robots=off http://www.example.org/
    ```

    This command will create a directory for the site you just downloaded. You can use this to host a mirror.
