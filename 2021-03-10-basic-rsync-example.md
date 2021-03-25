---
title: Basic Rsync example
description: Rsync is a command-line tool that makes copy files to and from a remote server super easy. It's also great for keeping backup folders and external drive in sync with each other.
date: 2021-03-10
---

I distro hop between Ubuntu-based Linux distributions fairly frequently. This means I'm often copy data to and from my backups and onto my laptop. I generally use Rsync for this, but I usually forget the command and have to find that _one_ particular website that has the exact collection of arguments and flags that I use. To stop me having to rummage around the internet every time I need to backup something, I'm putting that command here.

```shell
rsync --archive --verbose --delete --force --update /media/johnny/external-drive/Music/ ~/Music/
```

I _think_ the trailing slashes on those two paths are important. The rest of the flags are fairly simple:

| Flag | Purpose |
| --- | --- |
| `--archive` | Bundles a bunch of other commonly used flags into one. |
| `--verbose` | Print the output to the terminal so we can see what we're doing. |
| `--delete` | If a file or folder doesn't exist in the _source_, but it does exist in the _destination_ directory delete that folder in the _destination_ directory. |
| `--force` | This is combined with the `--delete` command. Forces Rsync to delete a directory even if it's not empty. | 
| `--update` | Only copies over files that don't exist in the destination folder, or if the source file has been modified more recently than the destination file. |
