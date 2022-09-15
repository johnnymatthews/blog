---
title: "Remove old Linux boot options in Windows"
description: "If you're like me, you'll often find yourself installing new and exciting Linux distros only to get bored of them a week later and saunter back on over to Windows. This is fine, but leaves me with a bunch of un-used boot options whenever I press F12 on start-up. This mini guide walks you through how to delete these boot options from within Windows."
date: 2022-09-14
---

I ran this stuff on Windows 11, but it should work on anything above Windows XP. If you're still running Windows XP, I know some people who would love to know your IP address.

1. Open CMD with elevated privileges.
1. Show your boot options with `bcdedit /enum firmware`:

    ```shell
    C:\Windows\system32>bcdedit /enum firmware

    > Firmware Boot Manager
    > ---------------------
    > identifier              {fwbootmgr}
    > displayorder            {e2de100a-3458-11ed-b382-806e6f6e6963}
    >                         {bootmgr}
    >                         {a416dc39-202a-11ed-95d0-dccf2c28a740}
    > timeout                 0

    > Windows Boot Manager
    > --------------------
    > identifier              {bootmgr}
    > device                  partition=\Device\HarddiskVolume1
    > path                    \EFI\MICROSOFT\BOOT\BOOTMGFW.EFI
    > description             Windows Boot Manager
    > locale                  en-US
    > inherit                 {globalsettings}
    > default                 {current}
    > resumeobject            {a416dc3c-202a-11ed-95d0-dccf2c28a740}
    > displayorder            {current}
    > toolsdisplayorder       {memdiag}
    > timeout                 30

    > Firmware Application (101fffff)
    > -------------------------------
    > identifier              {a416dc39-202a-11ed-95d0-dccf2c28a740}
    > path                    \EFI\SYSTEMD\SYSTEMD-BOOTX64.EFI
    > description             Pop!_OS 22.04 LTS


    > Firmware Application (101fffff)
    > -------------------------------
    > identifier              {e2de100a-3458-11ed-b382-806e6f6e6963}
    > device                  partition=\Device\HarddiskVolume5
    > path                    \EFI\UBUNTU\SHIMX64.EFI
    > description             elementary OS 6.1 Jólnir
    ```
	
1. Find the identifier of the boot option/s that you want to delete. I want to remove `elementary OS 6.1 Jólnir` and `Pop!_OS 22.04 LTS`.
1. Delete each boot option, in turn, with `bcdedit /delete <{identifier}>`:

    ```shell
    C:\Windows\system32>bcdedit /delete {a416dc39-202a-11ed-95d0-dccf2c28a740}
    
    > The operation completed successfully.
    ```

1. Run `bcdedit /enum firmware` to confirm that they have been deleted:

    ```shell
    C:\Windows\system32>bcdedit /enum firmware

    > Firmware Boot Manager
    > ---------------------
    > identifier              {fwbootmgr}
    > displayorder            {bootmgr}
    > timeout                 0

    > Windows Boot Manager
    > --------------------
    > identifier              {bootmgr}
    > device                  partition=\Device\HarddiskVolume1
    > path                    \EFI\MICROSOFT\BOOT\BOOTMGFW.EFI
    > description             Windows Boot Manager
    > locale                  en-US
    > inherit                 {globalsettings}
    > default                 {current}
    > resumeobject            {a416dc3c-202a-11ed-95d0-dccf2c28a740}
    > displayorder            {current}
    > toolsdisplayorder       {memdiag}
    > timeout                 30
    ```

1. Reboot. You should be good!
