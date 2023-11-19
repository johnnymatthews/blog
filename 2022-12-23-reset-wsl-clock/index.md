---
title: "Reset WSL clock"
description: "I'm not sure why this keeps happening, but every now and again the clock within WSL (and WSL2) get massively out of sync. Here's how to reset it."
date: 2022-12-23
---

1. Open WSL.
1. Use `hwclock -s` to set the system clock from the hardware clock:

    ```shell
    sudo hwclock -s
    ```

1. That's it.

## Update using NTPdate

For some reason, my Ubuntu clock gets out of sync with NTP servers on new installation. Here's how to deal with that.

1. Install `ntpdate`:

    ```shell
    sudo apt install ntpdate -y
    ```

1. Update your system clock with `ntpdate` using the [NIST](https://www.nist.gov/) time server:

    ```shell
    sudo ntpdate time.nist.gov
    ```

1. You should be good now!
