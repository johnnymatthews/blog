---
title: Random wallpaper script
description: Yet another blog post about setting your background wallpaper using a bash script. I know; revolutionary stuff.
date: 2021-05-14
---

Over the years I've collected a pretty substantial collection of cool looking wallpaper pictures. Most operating systems have a way of automatically choosing one at random whenever you log in. Sadly, my particular version of Ubuntu doesn't have this feature. So I've had to resort to creating my own script and adding that script to a CRON job. Shocking.

The script itself is really simple. First it creates a variable for the location of the wallpapers:

```shell
WALLPAPER_DIR="/home/johnny/Pictures/Wallpaper"
```

Then the script creates a new variable called `RANDOM_PICTURE` that is just the filename of a random image in the `WALLPAPER_DIR` directory:

```shell
RANDOM_PICTURE=$(ls $WALLPAPER_DIR -1 | shuf -n 1)
```

Lastly, the script takes those two variables and sets the `org.gnome.desktop.background` object as a `picture-uri`:

```shell
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/$RANDOM_PICTURE"
```

So the whole script looks like this:

```shell
#!/usr/bin/env bash

WALLPAPER_DIR="/home/johnny/Pictures/Wallpaper"
RANDOM_PICTURE=$(ls $WALLPAPER_DIR -1 | shuf -n 1)

gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/$RANDOM_PICTURE"
```

All that's left is to save this script somewhere, make it executable, and add it to a CRON job. To set a CRON job, open the crontable with `crontab -e` and create a new line:

```shell
15 10 * * * /home/johnny/Apps/random-wallpaper.sh
```

The line above sets CRON to run the `random-wallpaper.sh` script every day at 10:15. Lovely stuff.
