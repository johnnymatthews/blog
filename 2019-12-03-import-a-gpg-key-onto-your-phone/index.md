---
title: Import a GPG key onto your phone
description: GPG keys are a super secure way to encrypt your stuff. If you're an idiot like me and use Unix Pass everywhere, including on your phone, you'll need to import your GPG key from your PC to your phone. So this post goes over how to import a GPG key onto your phone, if not very briefly.
date: 2019-12-03
---

It's a bit of a pain, but it's possible to do. Here we go:

## Import a GPG key onto your phone

1. On your phone, install [OpenKeychain](https://www.openkeychain.org/)
2. On your computer run `gpg --list-secret-keys` to find out what keys you have available:

    ```bash
    $ gpg --list-secret-keys
    /Users/johnny/.gnupg/pubring.kbx
    --------------------------------
    sec   rsa4096 2019-11-25 [SC]
            A717D3E342CA94F3E04A51D4E2E4A167B1B617FE
    uid           [ultimate] Johnny
    ssb   rsa4096 2019-11-25 [E]
    ```

3. Export the key to the current directory:

    ```bash
    gpg --export-secret-keys $ID > my-private-key.asc
    ```

4. Transfer the `my-private-key.asc` file to your phone. This file isn't encrypted, so make sure you trust the transfer method.
5. On your phone open the OpenKeychain app.
6. Press the `+` button and select **Import from File**.
7. Select the folder icon and navigate to the `my-private-key.asc` file you transferred to your phone in step 4.
8. Select **Import**. The key should now be imported.

That's it! If everything went properly your GPG key should now be loaded on your phone.
