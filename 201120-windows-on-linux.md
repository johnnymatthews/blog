---
title: Windows on Linux
description: I saw a blog post the other day that discussed Windows moving onto the Linux kernel. So, instead of Windows running off DOS at a very low level, it would essentially be a Unix operating system. The post talked about all the benefitsthat Microsoft would yield from the move, along with how it would make things easier for the user. And while I much prefer Unix operating systems, moving Windows over to Linux is a bad idea. This post discusses why.
date: 2020-11-20
---

Firefox is the only remaining browser that isn't based on Chromium. This is bad because it means that Google has a finger in pretty much every browser out there. This happened in the past with Netscape. There was no competition, so there was no strive to innovate or challenge the status-quo.

Also, having Google controll 90% of the marketshare for browsers is super sketchy because it means they can just steamroll any feature they want, and all the other broswers will implement it by default. So they could, in theory, release a version of Chromium that loads Google owned websites much faster than others, or just completely block websites that Google doesn't agree with.

Another issue is that having everything based on one subsystem, be that Chronium or Unix, is that _everything_ is open to the same attacks. Kinda. Obviously attacks that target the file system or networking applications are going to be OS specific, but if someone finds a kernel level exploit, it means that **all** operating systems are affected. This is bad.

Cryptocurrencies often create multiple implementations of the same protocol, but in different languages. This is so that if there is a vulnerability found in a particular language, say Golang for example, then the blockchain implementations based on other languages are un-affected.
