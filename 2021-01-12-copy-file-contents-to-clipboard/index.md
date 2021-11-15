---
title: Copy file contents to clipboard.
description: "I often fine myself needing to copy the contents of a file into the system clipboard while fiddling around in the terminal. So I created a quick little function to help me."
date: 2021-01-12
---

Copying files is fun. Most of the time.

1. Open the RC file for your shell. I'm using ZSH, so I need to open `~/.zshrc`.
1. Create a new function called `copy`:

    ```shell
    function copy() {

    }
    ``` 

1. Within the function, use `cat` to return the contents of a file:

    ```shell
    function copy() {
        cat $1 
    }
    ```

    We're using the `$1` variable since we're going to pass in the file that we want to copy.

1. Pipe the output of `cat` to `xclip`:

    ```shell
    function copy() {
        cat $1 | xclip -i
    }
    ```

    The `-i` option tells xclip to expect content from standard input.

1. Tell xclip that we want to add this content to the secondary clipboard:

    ```shell
    function copy() {
        cat $1 | xclip -i -seletion clipboard
    }
    ```

    In Ubuntu/Debian based Linux distributions, the _main_ clipboard is accessed using the middle mouse button. Since I never use a mouse, this functionality is useless to me, so I need to address the regular `clipboard`.

1. Save and exit the RC file.
1. Source the file to get the updates:

    ```shell
    source ~/.zshrc
    ```

    Make sure to source your actual RC file. The destination might be different to what I've got here.

1. You should now be able to copy the contents of a file using `copy filename`:

    ```shell
    echo "This is a test." >> test.txt
    copy test.txt
    ```

    Pressing `ctrl` + `v` should now paste `This is a test.`! Don't forget to add your RC file to version control like Git!
