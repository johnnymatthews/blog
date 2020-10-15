---
title: Rsync files to Android
description: Rsync is a super handy utility that makes synchronising files between two systems incredibly simple. Unfortuantaly, Android doesn't allow users to use this utility straight out of the box. This post discusses why the restrictions exist, and how to ger around them using adb-sync.
date: 2020-07-17
---

This restriction has something to do with how Android is mounted when connected to a computer over USB. It's not actually a full file system, but uses media transfer protocol (MTP). MTP is ok, but can cause issues when transfering a large amount of data. For instance, I want to copy over my entire music library from my laptop to my phone. It's about 30GB, and MTP can sometimes crash about halfway through.

Annoyingly, to get Rsync to run natively on your Android you need to root the phone. There's a pros and cons to rooting a phone, but one major con is that it's a long and laborious task that I can't be bothered doing.

Enter ADB Sync! Google have thrown a package together that essentially acts as Rsync using the Android Debug Bridge (ADB) tool. It's super simple to use and does the job.

## Install ADB Sync

1. Install ADB on your computer:

    ```bash
    sudo apt install android-tools-adb -y
    ```

1. Check ADB is installed properly:

    ```bash
    adb --version

    > Android Debug Bridge version 1.0.39
    > Version 1:8.1.0+r23-5ubuntu2
    > Installed as /usr/lib/android-sdk/platform-tools/adb
    ```

1. Grab the ADB Sync package from GitHub and move it somewhere handy:

    ```bash
    git clone https://github.com/google/adb-sync
    cd adb-sync
    sudo cp adb-sync /usr/local/bin/
    ```

1. Check that ADB Sync is installed properly:

    ```bash
    adb-sync
    
    > usage: adb-sync [-h] [-e COMMAND] [--device] [--emulator] [-s DEVICE] [-H HOST] [-P PORT] [-R] [-2] [-t] [-d] [-f] [-n] [-L] [--dry-run] SRC [SRC ...] DST
    > adb-sync: error: the following arguments are required: SRC, DST
    ```

1. Now you can use `adb-sync` to _sync_ files between your computer and your phone.

## Sync files

To synchronize your music files from `~/Music` to your device:

```bash
adb-sync ~/Music /sdcard
```

To synchronize your music files from ~/Music to your device, deleting files you removed from your PC:

```bash
adb-sync --delete ~/Music /sdcard
```

To copy all downloads from your device to your PC:

```bash
adb-sync --reverse /sdcard/Download/ ~/Downloads
```

That's about it! Pretty simple stuff.
