---
title: Disable touchpad scroll-zoom in Firefox
description: It's super annoying when you're scrolling down a window and press `CTRL` for whatever reason. The whole window freaks out and starts zooming in. I don't really want this to happen, so here's how to disable the scroll-zoom in Firefox.
date: 2020-06-09
---

1. Go to [`about:config`](about:config) in Firefox.
1. Search for `mousewheel.with_control.action` and change it to `0`.
1. Search for `mousewheel.with_meta.action` and change it to `0`.

If you use Firefox Sync and want it to stick, add the following variables as `boolean` and set them to true:

```javascript
services.sync.prefs.sync.mousewheel.with_meta.action
services.sync.prefs.sync.mousewheel.with_control.action
```

That's about it! You should now have successfully disabled the touchpad scrolly thing.
