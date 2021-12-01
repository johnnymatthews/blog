---
title: Remove crap from your music library
description: Over the years I've accumulated a bunch of crap in my music library. Lots of `DS_Store` and `.dat` files, bouncing around for no particular reason. I found out that I can clean everything up with just a couple of commands! 
date: 2021-05-04
---

Run this to get rid of all your crap:

```shell
grep --exclude=\*.{mp3,Mp3,m4a,flac,jpg,jpeg,png,wav} --exclude-dir=Playlists --recursive --line-number -wl . > ~/delete-these
for f in delete-these; do rm ${f}; done;
```

The first runs through your library and finds any file that doesn't have any of the listed extensions. It also ignores the `Playlists` folder - there's a lot of crap in there that I'm not ready to touch just yet. Any file the command finds is added to a file called `delete-these`.

The second line _foreaches_ through each line in `delete-these` and deletes the corresponding line in that file. The `delete-these` file looks something like this:

```plaintext
...
EDEN/End Credits/.DS_Store
EDEN/Crazy In Love/.DS_Store
The Home Team/Better Off (2018)/._.DS_Store
The Home Team/Better Off (2018)/.DS_Store
...
```

It's worth mentioning that you need to be within your `Music` folder for these two lines to actually do anything useful. Also, the deletion in the second command is irreversable. Once it's ran, you're not getting that stuff back.

