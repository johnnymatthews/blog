---
title: "Dual boot Windows 11 and Ubuntu"
description: "Windows 11 is good for playing games, but crap at everything else. Ubuntu is good for development, but crap for playing games. So it's time to dual-boot! Unfortunately, Windows and Ubuntu don't play nicely together, so there's a few things we need to do so we can't get them both installed."
date: 2022-03-01
---

This is fun.

## Install Windows

1. Run a clean install of Windows.
1. Run Windows Update and leave for about 10 minutes.
1. Open Disk Management and shrink the space by about 300 GB.
1. Download your Ubuntu distribution of choice and create a bootable USB stick.
1. Shut down your PC.

That was the easy bit.

## BIOS configuration

Here comes the finicky stuff.

1. Boot your PC and go into the BIOS by mashing `<DEL>`.
1. Disable **Fastboot**.
1. Disable **Secure Boot**.
1. Disable **Discrete graphics**, if you can. This option is only available on PCs or laptops with a dedicated graphics card.
1. Save the BIOS settings and shut down your computer.

Next up; installing Ubuntu.

## Install Ubuntu

1. Pop in the Ubuntu install media and restart the machine.
1. Select **Custom install**.
1. Select **Modify partitions**.
1. Create the following partitions:

    | New size | Create as | Partition name | File system |
    | --- | --- | --- | --- |
    | 800 MiB | `Primary Partition` | `bootEfi` | `fat32` |
    | RAM x2 | `Primary Partition` | n/a | `linux-swap` |
    | Remaining space | `Primary Partition` | `root` | `ext4` |

1. Select **Apply changes**.
1. Select each partition by toggling on the **Use partition** switch and:

    | Identifier | Format | Use as | Filesystem |
    | --- | --- | --- | --- |
    | 838.9 MB (fat32) | True | `Boot (/boot/efi)` | `fat32` |
    | 286.9 GB (ext4) | True | `Root (/)` | `Default (ext4)` |
    | 34.4 GB (swap) | n/a | `Swap` | n/a |

1. Select **Erase and Install**.

## That's it

Assuming everything worked correctly, you should now be able to boot into Windows and Ubuntu. Since you installed Ubuntu last, I'm pretty sure that your BIOS will favor that when it comes to automatically booting. If you want to boot into Windows, smash `<F12>` when booting your machine. Or you can enter the BIOS again and change the boot order in the **BOOT** tab.
