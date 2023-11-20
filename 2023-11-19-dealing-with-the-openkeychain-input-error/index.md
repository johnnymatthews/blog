---
title: "Dealing with the OpenKeychain input error"
description: "The OpenKeychain app on Android is used for managing GPG keys on your mobile device. However, it's stuck on GPG version 2.2.0."
date: 2023-11-19
---

If you created a GPG key on your computer using a GPG version _higher_ than 2.2.0, OpenKeychain will likely throw an error when trying to read it:

> Error from OpenKeyChain: Encountered an error reading input data!

I recently encountered this error when updating my keys for my password store. To get around the error, you can temporarily install an older version of GPG, re-initialize your password store, and re-export your keys to your Android device.

1. Install GnuPG version 2.2:

    ```shell
    brew install gnupg@2.2
    ```

1. Specify that you want to use this specific GPG version for your current terminal session:

    ```shell
    echo 'export PATH="/opt/homebrew/opt/gnupg@2.2/bin:$PATH"' >> /Users/johnnymatthews/.bash_profile && source ~/.bash_profile
    ```

    Replace `johnnymatthews` with your username.

1. Re-initialise your password store:

    ```shell
    pass init johnny
    ```

    Replace `johnny` with the identifier of your key.

1. Push any changes to your remote pass store:

    ```shell
    pass git push
    ```

1. Re-export your key:

    ```shell
    gpg --export-secret-keys johnny > private.key
    ```

    Again, replace `johnny` with the identifier of your key.

1. Securely copy `private.key` to your Android device. 
1. Delete your old key from the OpenKeychain app and import the `private.key` file.
1. Pull your password store changes from Git.

You should now be able to view your passwords with your GPG key! At this point, you can remove the old version of GPG from your system with:

```shell
brew remove gnupg@2.2
rm -rf /opt/homebrew/etc/gnupg
```
