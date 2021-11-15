---
title: Create an Encrypted Zip File on MacOS
description: This guide will quickly walk you through how to create an encrypted zip file on a Mac. Since macOS and Linux systems have a lot in common, this will likely work on any Linux distributions too.
date: 2018-05-09
---

It's a pretty simple process, so let's dive into it:

1. Move the files you want to compress and encrypt to your Desktop.
2. Open Terminal by pressing `CMD` + `SPACE` and searching for **Terminal** in the search window that pops up.
3. Run the following command to zip and encrypt the selected files:

    ```shell
    zip -e ~/Desktop/zip-file.zip ~/Desktop/secret.txt
    ```

4. Enter a password to encrypt your `.zip` file with.
5. Enter the password again to make sure it's correct.
6. The `zip` application will compress your file(s) into a `.zip` and encrypt it at the same time.

It's a good idea to delete the raw file(s) now so no-one can access them without using the password. To do this enter the following into the terminal: `rm -rf secret.txt` where **secret.txt** is the name of your file. If you have more than one, simply add on the names of the file like this: `rm -rf secret.txt secret_two.jpg third_file.docx something-else.mp3`.

Happy coding.

