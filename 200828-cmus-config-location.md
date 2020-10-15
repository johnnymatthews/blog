---
title: CMUS config location
description: CMUS is an incredibly simple music and media player that runs straight from the terminal. However, sometimes it can be tricky to customize and interact with. In this post I'll quickly jump into where the config files for CMUS are, and how to edit them.
date: 2020-08-28
---

So there isn't a `.config` file for CMUS. But there _is_ a `cmus` folder within my system's `~/.config` folder. This `~/.config/cmus` folder contains:

```text
├── autosave
├── cache
├── command-history
├── lib.pl
├── playlists
│   ├── Aggressive alectro
│    ...
├── search-history
└── update-library.sh
```

I was looking for a `.config` file so I could add it to my post-linux-intstall-script. Turns out `autosave` serves the function of a `.config` file. It just contains a list of commands that run every time CMUS starts. It's a pretty long list:

```text
set aaa_mode=all
set altformat_current= %F 
set altformat_playlist= %f%= %d 
set altformat_title=%f
set altformat_trackwin= %f%= %d 
set auto_expand_albums_follow=true

...

fset ogg-or-mp3=ogg|mp3
fset unheard=play_count=0
factivate
```

This looks like a decent place to create `fset` rules for playlists and other bindings. I'll have to take a look into this file a bit more.
