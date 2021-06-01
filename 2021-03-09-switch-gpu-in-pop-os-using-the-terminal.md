---
title: Switch GPU in Pop OS using the terminal
date: 2021-03-09
description: Sometimes, you need a beefy GPU to process all the shaders in Metro 2033. And other times, you just need the integrated CPU graphics to show you a terminal window while you try to rebuild a Lotus binary on the train to Kings Cross without your battery crapping out. 
---

PopOS has a feature where you can select which GPU you'd like to use: internal or Nvidia. Usually, this setting is set by clicking on the battery icon and choosing with graphics processor you'd like to use. However, if you install another desktop environment, like [Regolith](https://regolith-linux.org/), this battery icon is no longer available. Fortunately, you can switch GPU with a couple of terminal commands.

1. Find out what CPU you're currently using:

    ```shell
    sudo system76-power graphics

    > nvidia
    ``` 

1. Switch to integrated graphics:

    ```shell
    sudo system76-power graphics integrated 
    ```

    If this command is successful, it will output nothing.

1. Reboot your machine:

    ```shell
    reboot
    ``` 

1. Once your system has finished booting, check that you are now running on integrated graphics:

    ```shell
    sudo system76-power graphics

    > integrated 
    ```

1. To switch back to dedicated graphics, follow the same steps using `nvidia` instead of `integrated`:

    ```shell
    sudo system76-power graphics nvidia
    reboot

    > ...

    sudo system76-power graphics

    > nvidia
    ```

1. That should do it.

## Troubleshooting

The integrated graphics processor is named something like `intel` or `amd` on some systems. If switching to `integrated` graphics gives an error, the `system76-power` executable should show which name you likely need to use. On my system, `intel` isn't recognized:

```shell
sudo system76-power graphics intel 

> error: The subcommand 'intel' wasn't recognized
>         Did you mean 'integrated'?
> 
> If you believe you received this message in error, try re-running with 'system76-power graphics --intel'
>
> USAGE:
>   system76-power graphics [SUBCOMMAND]
>
> For more information try --help
```

