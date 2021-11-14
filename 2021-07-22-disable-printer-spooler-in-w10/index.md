---
title: Disable print-spooler in W10
description: The printer-spooler in Windows 10 is all kinds of fucked, and is a common entry-point for attackers into a W10 system. The best protection right now is to just turn it off until you need to print something. 
date: 2021-07-22
---

## Turn the print-spooler off

1. Open a Command Prompt window with admin privilages.
1. Run the following:

    ```shell
    net stop spooler && sc config spooler start=disabled
    ```

1. You're now safe from any print-spooler based attacks.

## Turn it back on

1. Open a Command Prompt window with admin privilages.
1. Run the following:

    ```shell
    sc config spooler start=auto && net start spooler
    ```

1. Print off your stuff, then immedietly run the [disable](#turn-the-print-spooler-off) command.

It's a weird workaround, but it works.
