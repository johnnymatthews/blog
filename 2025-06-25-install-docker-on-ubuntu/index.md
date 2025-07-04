---
title: "Install Docker on Ubuntu"
description: "Yeah, this isn't revolutionary and there are 1000% better scripts out there. But I frequrently find myself needing to install Docker on Ubuntu VMs, and since I use this blog repo as my personal knowledge-base, here we are."
date: 2025-06-25
---

Alright, here we go:

1. Grab [this script](./install-docker.sh):

  ```shell
  wget https://johnnymatthews.dev/blog/2025-06-25-install-docker-on-ubuntu/install-docker-on-ubuntu.sh
  ```

1. Give it executable permissions:

  ```shell
  chmod +x install-docker-on-ubuntu.sh
  ```

1. Run it:

  ```shell
  ./install-docker-on-ubuntu.sh
  ```

1. Enable the new `docker` group that your user is now in:

  ```shell
  newgrp docker
  ```

> But Johnny, why do I have to run that `newgrp` thing _after_ the script? Why not just add that into the script itself!

You _can_ run `newgrp docker` at the end of the script, but shit won't do what you think it'll do. When you run `newgrp` in a script, it starts a new shell with the docker group active, but this new shell is confined to the script's execution context. Once the script ends, you get kicked out to your original shell session where the group change isn't active.

Anyway, that's everything. Be gone.
