---
title: Connect to a Raspberry Pi Zero over USB on Ubuntu
date: 2021-02-06
---

# Connect to a Raspberry Pi Zero over USB on Ubuntu

1. Format micro SD card the normal way.
1. Put an operating system on there using the [Raspberry Pi Imager for Ubuntu](https://www.raspberrypi.org/software/).
1. Change directory into the `boot` partition of the micro SD card:

    ```profile
    cd /media/johnny/boot
    ```

1. Create a blank `ssh` file:

    ```profile
    touch ssh
    ```

1. Add `dtoverlay=dwc2` to the end of `config.txt`:

    ```profile
    echo "dtoverlay=dwc2" >> config.txt
    ```

1. Add `modules-load=dwc2,g_ether` directly after `rootwait` within `cmdline.txt`:

    ```profile
    sed -i 's/rootwait/rootwait modules-load=dwc2,g_ether /g' input.txt
    ```

1. Plug a micro-usb cable into the port _closest_ to the HDMI port on the Raspberry Pi Zero. Plug the other end of the cable into your computer.
1. Wait two minutes for the Raspberry Pi Zero to finish doing it's thing.  
1. Open the **Network** panel in **Settings** and click the _gear icon_ to open the settings for the **Wired connection**:
1. Go to the **IPv6** tab and set the **IPv6 Method** to **Disable**.
1. Go to the **IPv4** tab and set the **IPv4 Method** to **Link-Local Only**.
1. Click **Apply**.
1. Toggle the **Wired** connection off and then on again.
1. Ping the Raspberry Pi Zero:

    ```profil
    ping raspberrypi.local

    > PING raspberrypi.local (169.254.194.96) 56(84) bytes of data.
    > 64 bytes from raspberrypi.local (169.254.194.96): icmp_seq=1 ttl=64 time=0.952 ms
    > 64 bytes from raspberrypi.local (169.254.194.96): icmp_seq=2 ttl=64 time=0.536 ms
    ```

1. If you got a response to the `ping`, you should be able to connect to your Raspberry Pi Zero over USB. If you didn't get a response, you might need to reboot your computer.
1. If, after rebooting, you still can't connect to your Raspberry Pi Zero, try using a different micro USB cable. Some cables are designed to only transfer power and not data.
