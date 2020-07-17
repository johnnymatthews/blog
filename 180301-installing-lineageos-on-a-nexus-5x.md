---
title: Installing LineageOS on Nexus 5X from OSX
date: 2018-03-01
---

## Step 1: Prerequisite Downloads

1. Download [TWRP](https://dl.twrp.me/bullhead/) to your Downloads folder.
2. Download LineageOS package  to your Downloads folder.
3. Download Google Apps (arm64 version) to your Downloads folder.

## Step 2: Unlock the Bootloader

1. Enable USB debugging on phone.
1. Toggle OEM Unlock on phone.
1. Run `brew cask install android-platform-tools` in terminal.
1. Plug phone into computer.
1. Allow USB debugging on the phone using the popup.
1. Run `adb reboot bootloader` in terminal.
1. Run `fastboot devices` to verify the computer can find the phone.
1. Run `fastboot flashing unlock` in terminal.

## Step 3: Install a Custom Recovery Package using Fastboot

1. Run `adb reboot bootloader` in terminal.
1. Run `fastboot devices` to verify the computer can find the phone.
1. Run `~/Downloads
1. Run `fastboot flash recovery twrp-x.x.x-x-bullhead.img`. Change the file name to reflect the TWRP `.img` file you downloaded in Step 1.
1. Turn the phone off.
1. Hold the `Volume Down` and `Power` buttons down until you see the fastboot menu.

## Step 4: Install LineageOS from Recovery

1. Run `adb push filename.zip /sdcard/`. Change the filename to reflect the LineageOS `.zip` file you downloaded in Step 1.
1. Run `adb push filename.zip /sdcard/`. Change the filename to reflect the Google Apps `.zip` file you downloaded in Step 1.
1. On the phone, select **Wipe** and then **Advanced Wipe**.
1. Select **Cache**, **System**, and **Data**.
1. Swipe the bar at the bottom of the screen to wipe the partitions.
1. Go back to the main menu using the back arrow at the bottom of the screen.
1. Select **Install**.
1. Navigate to `/sdcard` and select the LineageOS `.zip` file you copied to the phone in Step 3.
1. Select **Add another ZIP**.
1. Navigate to `/sdcard` and select the Google Apps `.zip` file you copied to the phone in Step 3.
1. Follow the on-screen prompts to install the packages.
1. When the installation has finished select **Reboot**, and then **System**.
