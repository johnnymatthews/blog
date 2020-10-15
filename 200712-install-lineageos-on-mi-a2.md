---
title: Install LineageOS on Mi A2
description: Bored of the standard Android OS on your Xiaomi Mi A2? You might be interested in installing LineageOS, a free and open-source operating system for various devices based on the Android mobile platform. I created this post partly as a guide, and partly as a reminder for when I need to do this again in three months.
date: 2020-07-12
---

## Download images

Before we can install anything, we need to get the images that we're going to throw onto our device.

1. Download [LineageOS installation `.zip` file](https://download.lineageos.org/jasmine_sprout).
1. Download the [LineageOS recovery `.img`file](https://download.lineageos.org/jasmine_sprout).

## ADB and Fastboot

The Android Debug Bridge (ADB) is a command-line tool that lets you communicate with an Android device from a computer. Fastboot is a special diagnostic and engineering protocol that you can boot your Android device into. We'll be using these two tools to erase everything on the device, and then install a custom rom.

1. sudo apt install android-tools-adb android-tools-fastboot -y
1. Check ADB and Fastboot versions to make sure they both got installed properly:

	```bash
	adb --version

	> Android Debug Bridge version 1.0.39
	> Version 1:8.1.0+r23-5ubuntu2
	> Installed as /usr/lib/android-sdk/platform-tools/adb

	fastboot --version

	> fastboot version 1:8.1.0+r23-5ubuntu2
	> Installed as /usr/lib/android-sdk/platform-tools/fastboot
	```

## Developer mode and the bootloader

We need to enable developer mode on the device in order to turn on USB-debugging mode. The debugging mode allows our computer to talk to our phone through a USB cable.

1. On the phone, go to **Settings** > **System** > **About phone**.
1. Scroll down to **Build number** and click on it several times. Your phone will attempt to go into _developer mode_.
1. Enter your pin/pattern if asked for it.
1. Once it says _You are now a developer_ close the app.
1. Go to **Settings** > **System** > **Advanced** > **Developer options**.
1. On this page enable **USB debugging**. You may have to enter your pin/pattern.
1. On the same page, enable **OEM unlocking**. You may have to accept a warning about device protection features.

Now that we've got your phone ready, let's test the connection to your computer.

1. Plug your phone into your computer using a USB cable.
1. A warning may pop up on your phone asking if you want to allow the computer to access your device over USB? Select **Always all** and then **Allow**.
1. Reset your phone and boot into the bootloader by running this command:

	```bash
	adb reboot bootloader
	```

1. Your device should reboot and show a little guy in a Russian looking hat.

## OEM unlock 

Now that we're in the bootloader, we can start wiping and installing things. Again, this procedure will **erase everything on the phone**, so make sure stuff is backed up, and you've got a list of all the apps you want to download later.

1. Check that Fastboot can see your phone:

	```bash
	fastboot devices

	> 2ed7330 fastboot
	``` 
1. Even though we unlocked the bootloader within the phone, we still need to unlock the full OEM features in order to access the full phone when installing our rom. Unlock the full features of the phone:

	```bash
	fastboot oem unlock
	fastboot oem unlock_critical
	```

    Running `unlock_critical` may result in a error saying _you've already unlocked this_, or something like that. That's fine, it just means that the first `unlock` command did everything already.

## Install recovery image

The recovery image is what pops up when you boot your phone into _Recovery mode_. The default recovery that comes with Android phones doesn't do what we need, so we need to _flash_ a custom recovery mode onto the phone. Luckily, LineageOS has a recovery image we can use.

You will likely have to change the file names of some of the files listed in these commands.

1. Move to the directory where you downloaded the `lineage-17.1-recovery.img` file:

	```bash
	cd ~/Downloads
	```

1. _Flash_ the recovery image onto your phone:

	```bash
	fastboot flash boot lineage-17.1-recovery.img
	
	> target reported max download size of 536870912 bytes
	> sending 'boot_b' (24517 KB)...
	> OKAY [  0.822s]
	> writing 'boot_b'...
	> OKAY [  0.190s]
	``` 

	If you device doesn't respond, or the above command does absolutley nothing and just hangs, you have not have unlocked the bootloader fully. Exit the terminal, open a new one, and run `fastboot oem unlock && fastboot oem unlock_critical`, then try the above command again.

1. Continue booting your phone to the homepage: 

	```bash
	fastboot continue
	```

1. Unlock your phone.

## Install custom ROM

Now it's time to install the custom rom.

1. Reboot into recovery mode:

	```bash
	adb reboot recovery
	```

1. The LineageOS recovery menu should now be shown on your phone. It might be very dim. You should be able to control this menu using the touch screen. If the touchscreen doesn't do anything, use the volume keys to go up and down, and the power button to select an option.
1. Select **Factory Reset** > **Format data/factory reset** > **Format data**. The recovery menu should output the following at the bottom of your screen:

	```bash
	-- Wiping data...
	Formatting /data...
	Data wipe complete.
	```
1. Go back to the main menu. 
1. Select **Apply Update** > **Apply from ADB**.
1. On your computer sideload the package using ADB:

	```bash
	adb sideload lineage-17.1-jasmine_sprout-signed.zip

    > * daemon not running; starting now at tcp:5037
    > * daemon started successfully
    > serving: 'lineage-17.1-20200711-nightly-jasmine_sprout-signed.zip'  (~47%) 
	```

    You phone outputs where things are up to:

    ```bash
    Finding update package...
    Opening update package...
    Verifiying update package...
    Update verification package too 48.9 s (result 0)
    Installing update...
    Step 1/2
    Step 2/2

    Install completed with status 0.
    ```

1. Go back to the main menu.
1. Select **Reboot**. Your phone should now boot into LineageOS.

## Troubleshooting

### Commands don't do anything

This might have something to do with how your phone is connected to your computer. USB-C seems to be a bit flakey. I connected my phone to a USB-C hub using a USB-C to USB-A cable. That seemed to work.

### Installing Open Apps (GApps)

Annoyingly, there's currently no way to install GApps without rooting your phone.
