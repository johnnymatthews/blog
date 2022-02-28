---
title: Install LOTRO on Windows 11
description: "Have you tried to install Lord of the Rings Online (LOTRO) on Steam, but it just won't open? Well, it's not opening because the game relies on a particular version of C++, which Standing Stone Games does not distribute with the game. Here's how to install it."
date: 2022-02-28
---

The specific package we're looking for is _Microsoft Visual C++ 2010  x86 Redistributable Setup_. There are a few places to find this package:

## Microsoft's website

I grabbed a version of the C++ installer from [microsoft.com/en-us/download/confirmation.aspx?id=26999](https://www.microsoft.com/en-us/download/confirmation.aspx?id=26999). However, there's a chance that the link is now broken. Microsoft likes to move packages around to spice things up a bit.

## Search for it

If the above link to Microsoft _is_ dead, try searching for `Microsoft Visual C++ 2010  x86 Redistributable Setup`. Only download the package from an official Microsoft domain, though; there's a bunch of sketchy sites offering this package, but they're usually trojans or the like.

## Download it from this site

If, after those three steps, you still haven't managed to install the package, then I've made the package available on this site. 

### Using HTTP

[Here's the file](./vcredist_x86.exe).

If you're a nerd who likes to use PowerShell, you can download and verify the file with this command:

```powershell
wget https://johnnymatthews.dev/blog/2022-02-28-install-lotro-on-windows-11/vcredist_x86.exe
Get FileHash vcredist_x86.exe
```

Make sure the output of `Get FileHash` matches below:

```powershell
Algorithm       Hash                                                                   Path
---------       ----                                                                   ----
SHA256          99DCE3C841CC6028560830F7866C9CE2928C98CF3256892EF8E6CF755147B0D8       C:\Users\You\Downloa...
```

Only run the package once you've verified the SHA256 hash of the download matches above. If it doesn't, don't run the `.exe` and find another copy somewhere else.

### Using IPFS

The file is [also available on IPFS](https://ipfs.io/ipfs/QmfLnF7SE41vBhRAc7WKNr3TtxHatTUXudvpoNXru7e81e), somewhere. It's CID is: `QmfLnF7SE41vBhRAc7WKNr3TtxHatTUXudvpoNXru7e81e`

If you're a PowerShell nerd with IPFS installed, here are the commands you need to download the file:

```powershell
ipfs get QmfLnF7SE41vBhRAc7WKNr3TtxHatTUXudvpoNXru7e81e
```

## Following the install

Once you've got the C++ package installed, LOTRO _should_ open normally. If it doesn't, though, [check out this post on the Lord of the Rings Online support site](https://help.standingstonegames.com/hc/en-us/articles/115002036287--Nothing-happens-after-clicking-Play-on-the-launcher-OR-Game-crashes-after-clicking-play-on-the-launcher-).

