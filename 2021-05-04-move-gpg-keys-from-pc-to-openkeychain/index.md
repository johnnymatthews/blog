---
title: Move GPG keys from PC to OpenKeychain
description: "I often find myself resetting my phone, which means I have to reimport my GPG keys from my PC to the phone. And _every single time_, I go to the OpenKeychain FAQs to find the one command I need to run. So instead of doing that, I've throw that command here."
date: 2021-05-05
---

To export a GPG run:

```shell
gpg --armor --export-secret-keys SECRET_KEY_NAME | gpg --armor --symmetric --output key-export.sec.asc
```

You'll be asked to enter a password. Choose a long and strong one. If you're struggling to think of one, run `gpg --armor --gen-random 1 20` which will output a long random string for you. You'll have to enter this password when you import the key on your phone. I suggest using a USB cable to transfer the key `key-export.sec.asc` to your phone, since it's the most secure method.

Once you've copied the key over to your phone, and it's imported, make sure to delete the `key-export.sec.asc` file:

```shell
rm key-export.sec.asc
```

For some reason, MacOS doesn't let you export keys properly, so you may have to _export_ `GPG_TTY` to your shell. Run:

```shell
export GPG_TTY=$(tty)
```

And that's it! You're all done.

