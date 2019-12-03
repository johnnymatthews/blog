# Creating apps for China (and other oppressed countries)

China is pretty cool. They've got a thriving economy, the world's largest hardware electronics industry, thousands of years of fascinating history, and stunningly beautiful countryside. China is also batshit crazy. The Great Firewall of China is a massive barrier for people inside of the country who want to access sites and apps that the Chinese government doesn't deem appropriate.

Around 1998 China was interacting with the rest of the world after years of isolationism (keeping the countries resources and citizens to itself). Also, around this time, the internet started to become more popular with everyday people. The Chinese government feared that the growth of the internet would cause Chinese citizen to begin questioning their government, and might start a democratic movement within the country. Obviously, the Communist Party of China (the guys in power) were having none of this. So they started a project to protect the political ideologies of China by limiting access to foreign information sources and blocking external internet tools. 

All of this makes it very difficult for websites and applications to work within China. By blocking external IP addresses, China has made it impossible for foreign companies to have a chance at cracking the Chinese market.

This is where IPFS comes in.

<!-- TODO: find out why IPFS actually helps mitigate censorship. -->

If you want to build an app that is able to get around these restrictions, then the Inter Planetary File System (IPFS) is for you. I'm not going to go into too much detail about how IPFS works, but here's the basic gist:

1. You create a file and pass it through the IPFS program.
1. IPFS reads the file and creates an _address_ based on the content of the file. Two different files will have different addresses, but two copies of the same file will have the same address.
1. The program then uploads the file to the network.
1. Anyone can then use the address to view the file.

We go into this process a bit more at the [very end](#how-ipfs-actually-works) of this guide.

## Install IPFS

First up is to install IPFS on your computer so we can interact with the network. There's a few different ways we can do this, but the easiest is through the IPFS desktop application and it's available for the most popular operating systems.

Download the installer for your computer:

- [Windows](https://github.com/ipfs-shipyard/ipfs-desktop/releases/download/v0.9.7/ipfs-desktop-setup-0.9.7.exe)
- [macOS](https://github.com/ipfs-shipyard/ipfs-desktop/releases/download/v0.9.7/ipfs-desktop-0.9.7.dmg)
- [Ubuntu](https://github.com/ipfs-shipyard/ipfs-desktop/releases/download/v0.9.7/ipfs-desktop-0.9.7-linux-x86_64.AppImage)

The installation process is pretty simple, but it is slightly different for each operating system. If you get stuck, check out the IPFS forum for more help. Once the installer has finished, you'll see an IPFS icon in your status bar. Click on it to interact with the desktop app.

![The IPFS Desktop application lives in your status bar until closed.](media/191128-creating-apps-for-china/ipfs-desktop-status-bar-running.jpg)

The IPFS desktop app will live in your computer's status bar until it is closed. Now that we've got everything installed and running we can move onto uploading files to the IPFS network.

## Create a File

Before we get around to uploading anything though, we need to create the thing we're going to upload! We could make a boring _Hello World_ file and then just send that to the network, but that's no fun! So we're gonna create a simple bio page and upload that instead!

<!-- TODO: think of something fun to upload. -->

## Upload it to IPFS

<!-- TODO: Pass the file throught the IPFS Daemon and upload it to the network. -->

## View the File in a Browser

<!-- TODO: Have the user open up a website address in their browser. -->

## Next Steps

<!-- TODO: List a bunch of things the user could do with IPFS now that they know how it works. -->

## How IPFS actually works

<!-- TODO: Explain in more detail how IPFS works in terms of hashing a file, nodes hosting files close to each other, how the same file has the same address, etc. -->